module Arc
  class TransactionsController < ApplicationController
    before_action :authenticate_arc_arc_account!

    def finalize
      transaction = Customer::Transaction.find(params[:id])
      result = Arc::Transactions.new(transaction).call
      if result.success?
        redirect_to arc_dashboard_path, notice: "Transaction validated."
      else
        redirect_to arc_dashboard_path, alert: result.error
      end
    end
  end
end
