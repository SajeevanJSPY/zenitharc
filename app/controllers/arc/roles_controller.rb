module Arc
  class RolesController < ApplicationController
    def assign
      target = Arc::ArcAccount.find(params[:arc_account])
      admin = current_arc_account

      result = Arc::RoleAssigner.new(
        target_account: target,
        current_account: admin
      ).assign(params[:role])

      if result.success
        redirect_to home_dashboard_path, notice: "Role updated successfully."
      else
        redirect_to home_dashboard_path, alert: result.error
      end
    end
  end
end
