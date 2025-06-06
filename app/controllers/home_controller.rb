class HomeController < ApplicationController
  def index
    if user_signed_in?
      @user = current_user
      @accounts = @user.accounts
      @transactions = []
      @accounts.each do |acc|
        @transactions.push(Customer::Transaction.where("from_id = ? OR to_id = ?", acc.id, acc.id).order(created_at: :desc))
      end
      @transactions = @transactions.flatten.uniq
      @login_logs = @user.login_logs.order(logged_in_at: :desc).limit(5)
    end
  end

  def dashboard
    if user_signed_in?
      @user = current_user
      @accounts = @user.accounts
      @transactions = {}
      @accounts.each do |acc|
        @transactions[acc.id] = Customer::Transaction.where("from_id = ? OR to_id = ?", acc.id, acc.id).order(created_at: :desc)
      end

    elsif arc_account_signed_in?
      @users = Customer::User.all.limit(10)
      @transactions = Customer::Transaction.pending_status.order(created_at: :desc).limit(10)
      @roles = Arc::ArcAccount.roles.keys
    end
  end
end
