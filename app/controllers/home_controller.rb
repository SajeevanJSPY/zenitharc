class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @accounts = @user.accounts
      @transactions = Transaction.where("from_id = ? OR to_id = ?", @user.id, @user.id).order(created_at: :desc)
      @login_logs = @user.login_logs.order(logged_in_at: :desc).limit(5)
    end
  end
end
