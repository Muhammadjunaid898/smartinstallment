class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_sign_up_params, if: :devise_controller?
  
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :full_name, :password, company_attributes: [:name, :phone_number]])
  end

  def after_sign_in_path_for(resource)
    view_context.dashboard_path
  end

  def after_sign_out_path_for(resource)
    view_context.root_url
  end
end
