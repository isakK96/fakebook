class ApplicationController < ActionController::Base
  before_action :configure_permitted_paramiters, if: :devise_controller?

  protected

  def configure_permitted_paramiters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
