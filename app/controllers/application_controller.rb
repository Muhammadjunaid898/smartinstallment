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

  def assign_thread_current_user_and_role
    User.current_user = current_user
    User.current_ability = current_ability if current_user.present?
  rescue StandardError
    session.clear
  end

  def set_current_user
    assign_thread_current_user_and_role
    yield
  ensure
    User.current_user = nil
    User.current_ability = nil
  end

  def set_company
    if request.subdomain.present? && request.domain == APP_HOST
      Company.current_tenant = Company.find_by(subdomain: request.subdomain)
    else
      Company.current_tenant = nil
    end
    yield
  ensure
    Company.current_tenant = nil
  end
end
