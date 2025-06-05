# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :check_arc_account_signed_in, only: [ :new, :create ]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    if current_user
      return
    end
    @is_arc_account = false
    @is_customer_account = true
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
  def check_arc_account_signed_in
    if arc_account_signed_in?
      redirect_to root_path, alert: "Please log out from ArcAccount before signing in as User."
    end
  end
end
