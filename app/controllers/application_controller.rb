class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  def login_user_only
    unless current_user.present?
      redirect_back(fallback_location: root_url)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :nickname, :phone_number])
  end
end
