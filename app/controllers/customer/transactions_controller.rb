module Customer
  class TransactionsController < ApplicationController
    def make_transaction
      @from = current_user
      service = Customer::MakeTransaction.new(@from.id, params[:to])
      result = service.call(params[:transaction_type], params[:amount])

      if result.success
        redirect_to home_dashboard_path, notice: "Transaction Added Successfully"
      else
        redirect_to home_dashboard_path, alert: result.error
      end
    end
  end
end
