module Customer
  class HomeController < BaseController
    helper_method :customer_signed_in?, :current_customer

    skip_before_action :authenticate_customer!, only: [ :index ]
    before_action :prepare_dashboard_data, only: [ :dashboard ]

    def index
    end

    def dashboard
    end

    private

    def prepare_dashboard_data
      @accounts = current_customer.accounts

      @transactions = @accounts.each_with_object({}) do |acc, hash|
        hash[acc.id] = Customer::Transaction
          .where("from_id = :id OR to_id = :id", id: acc.id)
          .order(created_at: :desc)
      end
    end
  end
end
