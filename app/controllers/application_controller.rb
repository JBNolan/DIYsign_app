class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!, except: [:index]

  protected

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password, :email, :zip, :username]

    devise_parameter_sanitizer.permit(:sign_up, keys: [:zip, :username])

    devise_parameter_sanitizer.permit(:account_update, keys: [:zip, :username])
  end
end
