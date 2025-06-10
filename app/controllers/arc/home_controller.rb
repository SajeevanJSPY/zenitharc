module Arc
  class HomeController < BaseController
    helper_method :assignable_roles, :assignable_accounts

    skip_before_action :authenticate_arc_account!, only: [ :index ]
    before_action :prepare_dashboard_data, if: :arc_signed_in?, only: [ :dashboard ]

    def index
    end

    def dashboard
    end

    private

    def prepare_dashboard_data
      @transactions = Customer::Transaction.pending_status.order(created_at: :desc).limit(10)
    end

    # Helper methods
    def assignable_roles
      assignable_roles = Arc::ArcAccount.roles.keys
      if admin?
        assignable_roles -= [ "superadmin" ]
        assignable_roles -= [ "admin" ] if current_arc.admin_role?
      end
      assignable_roles
    end

    def assignable_accounts
      accounts = Arc::ArcAccount.all
      accounts -= [ current_arc ]
      accounts.reject { |acc| acc.superadmin_role? }
    end
  end
end
