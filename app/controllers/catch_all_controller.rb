class CatchAllController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def index
    InvalidRoute.create(url: request.url, relative_path: request.fullpath, request_type: request.request_method)
    render_404
  end 
end
