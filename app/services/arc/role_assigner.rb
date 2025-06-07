module Arc
  class RoleAssigner
    attr_reader :success, :error

    def initialize(target_account, current_account)
      @arc_account = target_account
      @admin_acc = current_account
      @success = false
      @error = nil
    end

    def assign(role)
      # Check if current user is allowed to assign the given role
      if role == "admin" && !@admin_acc.superadmin_role?
        @error = "Only superadmins can assign the 'admin' role."
        return self
      end

      unless @admin_acc.superadmin_role? || @admin_acc.admin_role?
        @error = "You don't have permission to change roles."
        return self
      end

      if @arc_account.update(role: role)
        @success = true
      else
        @error = @arc_account.errors.full_messages.to_sentence
      end

      self
    end
  end
end
