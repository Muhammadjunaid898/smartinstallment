# module to handle application level exceptions
module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::UnknownFormat, with: :render_406
    rescue_from ActiveRecord::StatementTimeout, with: :render_504
    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.html do
          redirect_to view_context.dashboard_url
        end
      end
    end
  end

  private

  def render_404
    file_path = "#{Rails.root}/public/404.html" 
    respond_to do |format|
      format.html { render file: file_path, status: :not_found, layout: false }
      format.any  { head 404 }
    end
  end

  def render_406
    file_path = "#{Rails.root}/public/406.html"
    respond_to do |format|
      format.html { render file: file_path, status: :not_acceptable, layout: false }
      format.js   { render js: 'Format not acceptable' }
      format.any  { head :not_acceptable }
    end
  end

  def render_504
    file_path = "#{Rails.root}/public/504.html" 
    respond_to do |format|
      format.html { render file: file_path, status: 504, layout: false }
      format.any  { head 504 }
    end
  end
end
