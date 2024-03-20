class UserCompaniesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def find
    respond_to do |format|
      format.html
    end
  end

  def index
  	@current_user = User.having_email_without_multitenancy(params[:email])
  	@current_company = @current_user.company if @current_user.present?

  	respond_to do |format|
      format.html do
      	if @current_company.present?
      	  redirect_to new_session_url(User, subdomain: @current_company.subdomain)
      	else
      	  flash.now[:alert] = "We could not recognize this email address"
          render :find
      	end
      end
    end
  end
end
