module Customer
  class HomeController < ApplicationController
    helper_method :customer_signed_in?, :current_customer

    before_action :redirect_unless_signed_in, only: [ :dashboard ]
    before_action :handle_user_dashboard, if: :customer_signed_in?, only: [ :index, :dashboard ]

    def index
    end

    def dashboard
    end

    private

    def handle_user_dashboard
      @user = current_customer
      @accounts = @user.accounts

      @transactions = @accounts.each_with_object({}) do |acc, hash|
        hash[acc.id] = Customer::Transaction
          .where("from_id = :id OR to_id = :id", id: acc.id)
          .order(created_at: :desc)
      end
    end

    def redirect_unless_signed_in
      unless customer_signed_in?
        redirect_to root_path, alert: "Customer account is not signed in. Please log in before accessing the dashboard."
      end
    end

    def customer_signed_in?
      customer_user_signed_in?
    end

    def current_customer
      current_customer_user
    end
  end
end
