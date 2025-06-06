module Admin
  class TransactionValidator
    def initialize(transaction)
      @transaction = transaction
    end

    def call
      return fail!("Not pending") unless @transaction.pending_status?
      from = Customer::Account.find_by(id: @transaction.from_id)
      return fail!("transfer failed") unless from.nil?

      if @transaction.transfer_transaction_type?
        to = Customer::Account.find_by(id: @transaction.to_id)
        if to.nil? || @transaction.amount > from.balance
          return fail!("Transfer failed")
        end
        @transaction.update(status: "completed")
      else
        fail!("we are not supporting deposit, or withdraw for now")
      end

      redirect_to home_dashboard_path
    end

    private

    def fail!(reason)
      @transaction.update(status: "failed")
      Rails.logger.info("Validation failed: #{reason}")
    end
  end
end
