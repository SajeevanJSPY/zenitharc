module Arc
  class HomeController < ApplicationController
    helper_method :arc_signed_in?, :current_arc

    before_action :redirect_unless_signed_in, only: [ :dashboard ]
    before_action :handle_arc_account_dashboard, if: :arc_signed_in?, only: [ :index, :dashboard ]

    def index
    end

    def dashboard
      @users_count = Arc::ArcAccount.count
    end

    private

    def handle_arc_account_dashboard
      @users = Customer::User.limit(10)
      @transactions = Customer::Transaction.pending_status.order(created_at: :desc).limit(10)
      @roles = Arc::ArcAccount.roles.keys
    end

    def redirect_unless_signed_in
      unless arc_signed_in?
        redirect_to root_path, alert: "Arc account is not signed in. Please log in before accessing the dashboard."
      end
    end

    def arc_signed_in?
      arc_arc_account_signed_in?
    end

    def current_arc
      current_arc_arc_account
    end
  end
end
