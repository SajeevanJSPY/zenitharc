class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @accounts = @user.accounts
      @transactions = Transaction.where("from_id = ? OR to_id = ?", @user.id, @user.id).order(created_at: :desc)
      @login_logs = @user.login_logs.order(logged_in_at: :desc).limit(5)
    end
  end

  def dashboard
    if user_signed_in?
      @user = current_user
      @is_admin = true

      if @is_admin
        @users = User.all.limit(10)
        @transactions = Transaction.pending_status
      else
        @transactions = Transaction.where("from_id = ? OR to_id = ?", @user.id, @user.id).order(created_at: :desc)
      end
    end
  end
end
