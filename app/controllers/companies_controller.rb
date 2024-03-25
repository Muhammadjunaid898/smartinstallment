class CompaniesController < ApplicationController
  load_and_authorize_resource

  def dashboard
  	respond_to do |format|
      format.html
    end
  end
end
