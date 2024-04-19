# module to handle application level exceptions
module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.html do
          redirect_to view_context.dashboard_url
        end
      end
    end
  end
end
