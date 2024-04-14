class CompaniesController < ApplicationController
  load_and_authorize_resource

  def dashboard
    @members = Company.current_tenant.users
    @categories = Company.current_tenant.categories
  	respond_to do |format|
      format.html
    end
  end
end
