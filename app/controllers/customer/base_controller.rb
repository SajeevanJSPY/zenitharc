module Customer
  class BaseController < ApplicationController
    helper_method :customer_signed_in?, :current_customer
    before_action :authenticate_customer!

    private

    # Before action methods
    def authenticate_customer!
      unless customer_signed_in?
        redirect_to customer_home_path, alert: "Customer account is not signed in. Please log in before accessing the dashboard."
      end
    end

    # Helper methods
    def customer_signed_in?
      customer_user_signed_in?
    end

    def current_customer
      current_customer_user
    end
  end
end
