# frozen_string_literal: true

module Arc
  module Devise
    class SessionsController < ::Devise::SessionsController
      # before_action :configure_sign_in_params, only: [:create]
      before_action :check_user_signed_in, only: [ :new, :create ]

      # GET /resource/sign_in
      def new
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
        if customer_user_signed_in?
          redirect_to root_path, alert: "Please log out from User before signing in as ArcAccount."
        end
      end
    end
  end
end
