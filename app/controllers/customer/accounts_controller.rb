module Customer
  class AccountsController < BaseController
    helper_method :arc_signed_in?
    skip_before_action :authenticate_customer!
    before_action :set_account
    before_action :authorize_account_access!

    def show
    end

    private

    def set_account
      @account = Customer::Account.find_by!(account_number: params[:account_number])
    end

    def authorize_account_access!
      return if arc_signed_in?
      return if customer_signed_in? && current_customer.id == @account.user_id

      redirect_to root_path, alert: "You are not authorized to view this account."
    end

    def arc_signed_in?
      defined?(current_arc_arc_account) && current_arc_arc_account.present?
    end
  end
end
