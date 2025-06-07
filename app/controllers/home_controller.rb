class HomeController < ApplicationController
  before_action :handle_user_index, only: :index
  before_action :handle_user_dashboard, if: :user_signed_in?, only: :dashboard
  before_action :handle_arc_account_dashboard, if: :arc_account_signed_in?, only: :dashboard

  def index
  end

  def dashboard
  end

  private

  def handle_user_index
    return unless user_signed_in?

    @user = current_user
    @accounts = @user.accounts

    @transactions = Customer::Transaction
      .where(from_id: @accounts.pluck(:id))
      .or(Customer::Transaction.where(to_id: @accounts.pluck(:id)))
      .order(created_at: :desc)
      .uniq

    @login_logs = @user.login_logs.order(logged_in_at: :desc).limit(5)
  end

  def handle_user_dashboard
    @user = current_user
    @accounts = @user.accounts

    @transactions = @accounts.each_with_object({}) do |acc, hash|
      hash[acc.id] = Customer::Transaction
        .where("from_id = :id OR to_id = :id", id: acc.id)
        .order(created_at: :desc)
    end
  end

  def handle_arc_account_dashboard
    @users = Customer::User.limit(10)
    @transactions = Customer::Transaction.pending_status.order(created_at: :desc).limit(10)
    @roles = Arc::ArcAccount.roles.keys
  end
end
