module Arc
  class AccountStatusUpdater
    attr_reader :success, :error

    def initialize(target_account:)
      @target = target_account
      @success = false
      @error = nil
    end

    def change_status(status)
      if @target.status == status
        @error = "Customer account is already at the desired status"
        return self
      end

      if @target.update(status: status)
        @success = true
      else
        @error = @target.errors.full_messages.to_sentence
      end

      self
    end
  end
end
