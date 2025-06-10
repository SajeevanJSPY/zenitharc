module Arc
  class RolesController < BaseController
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
  end
end
