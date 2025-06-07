class HomeController < ApplicationController
  before_action :handle_user_index, only: :index
  helper_method :customer_signed_in?, :current_customer, :arc_signed_in?, :current_arc

  def index
  end

  private

  def handle_user_index
    return unless customer_user_signed_in?

    @user = current_customer_user
    @accounts = @user.accounts

    @transactions = Customer::Transaction
      .where(from_id: @accounts.pluck(:id))
      .or(Customer::Transaction.where(to_id: @accounts.pluck(:id)))
      .order(created_at: :desc)
      .uniq

    @login_logs = @user.login_logs.order(logged_in_at: :desc).limit(5)
  end

  def customer_signed_in?
    customer_user_signed_in?
  end

  def current_customer
    current_customer_user
  end

  def arc_signed_in?
    arc_arc_account_signed_in?
  end

  def current_arc
    current_arc_arc_account
  end
end
