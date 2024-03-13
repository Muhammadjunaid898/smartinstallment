class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_sign_up_params, if: :devise_controller?
  around_action :set_company
  
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :full_name, :password, company_attributes: [:name, :phone_number]])
  end

  def after_sign_in_path_for(resource)
    # view_context.dashboard_path
    view_context.dashboard_url(subdomain: Company.current_tenant.subdomain)
  end

  def after_sign_out_path_for(resource)
    view_context.root_url
  end

  private 

  def set_company
    Company.current_tenant = Company.find_by(subdomain: request.subdomain)
    # company = Company.find_by(subdomain: request.subdomain)
    # Company.current_company_id = company.id
    yield
  # rescue ActiveRecord::RecordNotFound
  #   render file: "#{Rails.root}/public/404.html", status: :not_found
  ensure
    Company.current_company_id = nil
  end
end
