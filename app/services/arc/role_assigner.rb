module Arc
  class RoleAssigner
    attr_reader :success, :error

    def initialize(target_account:, current_account:)
      @target = target_account
      @admin = current_account
      @success = false
      @error = nil
    end

    def assign(role)
      unless valid_role?(role)
        @error = "Invalid role."
        return self
      end

      unless has_permission?
        @error = "You do not have permission to assign roles."
        return self
      end

      if role == "admin" && !@admin.superadmin_role?
        @error = "Only a superadmin can assign the 'admin' role."
        return self
      end

      if @target.role == role
        @error = "User already has the role '#{role}'."
        return self
      end

      if @target.update(role: role)
        @success = true
      else
        @error = @target.errors.full_messages.to_sentence
      end

      self
    end

    private

    def valid_role?(role)
      Arc::ArcAccount.roles.key?(role) && role != "superadmin"
    end

    def has_permission?
      @admin.superadmin_role? || @admin.admin_role?
    end
  end
end
