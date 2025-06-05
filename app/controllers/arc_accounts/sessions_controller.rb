# frozen_string_literal: true

class ArcAccounts::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :check_user_signed_in, only: [ :new, :create ]

  # GET /resource/sign_in
  def new
    @is_arc_account = true
    @is_customer_account = false
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def check_user_signed_in
    if user_signed_in?
      redirect_to root_path, alert: "Please log out from User before signing in as ArcAccount."
    end
  end
end
