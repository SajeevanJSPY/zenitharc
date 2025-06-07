module Arc
  class HomeController < ApplicationController
    layout "arc"
    before_action :handle_arc_account_dashboard, if: :arc_arc_account_signed_in?, only: [ :index, :dashboard ]
    helper_method :arc_signed_in?

    def index
    end

    def dashboard
    end

    private

    def handle_arc_account_dashboard
      @users = Customer::User.limit(10)
      @transactions = Customer::Transaction.pending_status.order(created_at: :desc).limit(10)
      @roles = Arc::ArcAccount.roles.keys
    end

    def arc_signed_in?
      arc_arc_account_signed_in?
    end

    def arc_account
      current_arc_arc_account
    end
  end
end
