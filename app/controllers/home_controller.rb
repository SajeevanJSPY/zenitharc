class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @accounts = @user.accounts
      @transactions = Customer::Transaction.where("from_id = ? OR to_id = ?", @user.id, @user.id).order(created_at: :desc)
      @login_logs = @user.login_logs.order(logged_in_at: :desc).limit(5)
    end
  end

  def dashboard
    if user_signed_in?
      @user = current_user
      @transactions = Customer::Transaction.where("from_id = ? OR to_id = ?", @user.id, @user.id).order(created_at: :desc)
    elsif arc_account_signed_in?
      @users = Customer::User.all.limit(10)
      @transactions = Customer::Transaction.pending_status
    end
  end
end
