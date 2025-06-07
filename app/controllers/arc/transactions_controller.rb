module Arc
  class Transactions < ApplicationController
    def finalize_transaction
      transaction = Customer::Transaction.find(params[:id])
      result = Arc::ValidateTransaction.new(transaction).call
      if result.success?
        redirect_to home_dashboard_path, notice: "Transaction validated."
      else
        redirect_to home_dashboard_path, alert: result.error
      end
    end
  end
end
