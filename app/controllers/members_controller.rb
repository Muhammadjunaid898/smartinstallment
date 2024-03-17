class MembersController < ApplicationController
	def new
		@user = User.new
	end

	def create
	  @user = User.new(member_params)
	  # @user.company = Company.find(1)
	  @user.company = @current_company
	  @user.new_company_member = true
	  
	  # If new_company_member is true, skip password validation
	  bypass_password_validation if @user.new_company_member

	  if @user.save
	    redirect_to member_path(@user), notice: 'Member was successfully created.'
	  else
	    render :new
	  end
	end

	def show
		@member = User.find(params[:id])
	end

	private

	def member_params
		params.require(:user).permit(:email, :full_name)
	end

	def bypass_password_validation
	  @user.define_singleton_method(:password_required?) { false }
	end
end
