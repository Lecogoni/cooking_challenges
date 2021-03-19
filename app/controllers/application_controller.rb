class ApplicationController < ActionController::Base

  before_action :configure_devise_parameters, if: :devise_controller?


  # Method qui permet a devise de prendre :username en compte lors du sign_up
  def configure_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:username, :email, :password, :password_confirmation)}
  end

  protected

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end


  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

end
  