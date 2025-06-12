module Arc
  class CustomerAccountsController < BaseController
    def update_status
      target = Customer::Account.find_by(id: params[:customer_account_id])
      unless target
        return redirect_to arc_dashboard_path, alert: "Account not found"
      end

      result = Arc::AccountStatusUpdater.new(
        target_account: target,
      ).change_status(params[:status])

      if result.success
        redirect_to arc_dashboard_path, notice: "Customer account status updated to #{params[:status]}."
      else
        redirect_to arc_dashboard_path, alert: result.error
      end
    end
  end
end
