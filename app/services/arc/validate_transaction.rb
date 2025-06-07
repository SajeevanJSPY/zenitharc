module Arc
  class ValidateTransaction
    attr_reader :transaction, :error

    def initialize(transaction)
      @transaction = transaction
      @error = nil
    end

    def call
      return fail!("Not pending") unless @transaction.pending_status?

      from = Customer::Account.find_by(id: @transaction.from_id)
      return fail!("transfer failed") unless from.nil?

      case transaction.transfer_type
      when "transfer"
        to = Customer::Account.find_by(id: transaction.to_id)
        return fail!("To account not found") if to.nil?
        return fail!("Insufficient balance") if transaction.amount > from.balance

        transaction.update(status: "completed")
        @success = true
      else
        fail!("Only 'transfer' transactions are supported currently")
      end

      self
    end

    def success?
      @success == true
    end

    private

    def fail!(reason)
      transaction.update(status: "failed")
      @error = message
      Rails.logger.warn("Transaction validation failed: #{message}")
      @success = false
    end
  end
end
