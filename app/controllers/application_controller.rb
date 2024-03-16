class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  around_action :set_company
  
  def after_sign_in_path_for(resource)
    view_context.dashboard_path
  end

  def after_sign_out_path_for(resource)
    view_context.root_url
  end

  private 

  def set_company
    Company.current_tenant = Company.find_by(subdomain: request.subdomain)
    yield
  ensure
    Company.current_tenant = nil
  end
end
