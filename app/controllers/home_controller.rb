class HomeController < ApplicationController
  before_action :handle_user_index, only: :index

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
end
