module Arc
  class Transactions
    attr_reader :transaction, :error

    def initialize(transaction)
      @transaction = transaction
      @error = nil
      @success = false
    end

    def call
      return fail!("Transaction is not pending.") unless transaction.pending_status?

      from_account = Customer::Account.find_by(id: transaction.from_id)
      return fail!("Sender account not found.") if from_account.nil?

      case transaction.transaction_type
      when "transfer"
        process_transfer(from_account)
      else
        fail!("Only 'transfer' transactions are supported currently")
      end

      self
    end

    def success?
      @success
    end

    private

    def process_transfer
      to_account = Customer::Account.find_by(id: transaction.to_id)
      return fail!("Receiver account not found.") if to_account.nil?

      if transaction.amount > from_account.balance
        return fail!("Insufficient balance in sender's account.")
      end

      ActiveRecord::Base.transaction do
        from_account.update(balance: from_account.balance - transaction.amount)
        to_account.update(balance: to_account.balance + transaction.amount)
        transaction.update!(status: "completed")
      end

      @success = true
    rescue => e
      fail!("Transaction processing error: #{e.message}")
    end

    def transfer_amount(from, to, amount)
      from_new_balance = from.balance - amount
      to_new_balance = to.balance + amount
      from.update(balance: from_new_balance)
      to.update(balance: to_new_balance)
    end

    def fail!(reason)
      transaction.update(status: "failed") if transaction.persisted?
      @error = reason
      Rails.logger.warn("Transaction failed: #{reason}")
      self
    end
  end
end
