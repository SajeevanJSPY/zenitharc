module Customer
  class MakeTransaction
    attr_reader :success, :error, :transaction

    def initialize(from_account_id, to_account_id = nil)
      @from_account_id = from_account_id
      @to_account_id = to_account_id
      @success = false
      @error = nil
      @transaction = nil
    end

    def call(transaction_type, amount)
      return fail!("Amount must be greater than 0") unless amount.positive?

      @from_account = Customer::Account.find_by(id: @from_account_id)
      return fail!("From account not found") if @from_account.nil?

      if transaction_type == "transfer"
        return fail!("To account is required for transfer") if @to_account_id.nil?
        @to_account = Customer::Account.find_by(id: @to_account_id)
        return fail!("To account not found") if @to_account.nil?
        return fail!("Insufficient balance") if @from_account.balance < amount
      end

      @transaction = @from_account.sent_transactions.create(
        transaction_type: transaction_type,
        to_id: @to_account&.id,
        amount: amount,
      )

      if @transaction.persisted?
        @success = true
      else
        @error = @transaction.errors.full_messages.to_sentence
      end

      self
    end

    def fail!(message)
      @error = message
      @success = false
      self
    end
  end
end
