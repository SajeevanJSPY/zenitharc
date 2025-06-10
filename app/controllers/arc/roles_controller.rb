module Arc
  class RolesController < ApplicationController
    before_action :authenticate_arc_arc_account!
    before_action :authorize_admin!

    def assign
      target = Arc::ArcAccount.find_by(id: params[:arc_account_id])
      unless target
        return redirect_to arc_dashboard_path, alert: "Target account not found."
      end

      result = Arc::RoleAssigner.new(
        target_account: target,
        current_account: current_arc
      ).assign(params[:role])

      if result.success
        redirect_to arc_dashboard_path, notice: "Role updated successfully."
      else
        redirect_to arc_dashboard_path, alert: result.error
      end
    end

    private

    def authorize_admin!
      return if current_arc.admin_role? || current_arc.superadmin_role?

      redirect_to arc_dashboard_path, alert: "You are not authorized to assign roles."
    end

    def current_arc
      current_arc_arc_account
    end
  end
end
