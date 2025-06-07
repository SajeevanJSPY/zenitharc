module Customer
  class HomeController < ApplicationController
    before_action :handle_user_dashboard, if: :customer_user_signed_in?, only: [ :dashboard ]
    before_action :handle_user_dashboard, if: :customer_user_signed_in?, only: [ :index ]

    def index
    end

    def dashboard
    end

    private

    def handle_user_dashboard
      @user = current_user
      @accounts = @user.accounts

      @transactions = @accounts.each_with_object({}) do |acc, hash|
        hash[acc.id] = Customer::Transaction
          .where("from_id = :id OR to_id = :id", id: acc.id)
          .order(created_at: :desc)
      end
    end
  end
end
