module Arc
  class BaseController < ApplicationController
    helper_method :arc_signed_in?, :current_arc, :admin?, :super_admin?
    before_action :authenticate_arc_account!

    private
    # Before action methods
    def authenticate_arc_account!
      unless arc_signed_in?
        redirect_to arc_home_path, alert: "Arc account is not signed in. Please log in before accessing the dashboard."
      end
    end

    def authorize_admin!
      return if admin?

      redirect_to arc_dashboard_path, alert: "You are not authorized to perform this action."
    end

    # Helper methods
    def arc_signed_in?
      arc_arc_account_signed_in?
    end

    def current_arc
      current_arc_arc_account
    end

    def admin?
      current_arc&.admin_role? || current_arc&.superadmin_role?
    end

    def super_admin?
      current_arc&.superadmin_role?
    end
  end
end
