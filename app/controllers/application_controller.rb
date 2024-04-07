class ApplicationController < ActionController::Base
  include ErrorHandler

  around_action :set_company
  around_action :set_current_user
  before_action :authenticate_user!, unless: :devise_controller?
  
  def after_sign_in_path_for(resource)
    view_context.dashboard_url
  end

  def after_sign_out_path_for(resource)
    view_context.root_url
  end

  def current_company
    Company.current_tenant 
  end

  private 

  def set_current_user
    begin
      User.current_user = current_user
      User.current_ability = current_ability if current_user.present?
    rescue => e
      session.clear
    end
    yield
  ensure
    User.current_user = nil
    User.current_ability = nil
  end

  def set_company
    Company.current_tenant = Company.find_by(subdomain: request.subdomain)
    yield
  ensure
    Company.current_tenant = nil
  end
end
