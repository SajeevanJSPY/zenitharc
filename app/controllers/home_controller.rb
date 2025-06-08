class HomeController < ApplicationController
  helper_method :customer_signed_in?, :arc_signed_in?

  def index
  end

  private

  def customer_signed_in?
    customer_user_signed_in?
  end

  def arc_signed_in?
    arc_arc_account_signed_in?
  end
end
