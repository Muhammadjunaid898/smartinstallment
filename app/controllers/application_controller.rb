class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    view_context.dashboard_path
  end

  def after_sign_out_path_for(resource)
    view_context.root_url
  end
end
