class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource

  def new
    @member = User.new
  end

  def create
  	@member = User.new(member_params)
    @member.company = Company.find(1)
    @member.new_company_member = true

    bypass_password_validation if @member.new_company_member

    if @member.save!
      redirect_to member_path(@member), notice: 'Member was successfuly created.'
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def index
  	@members = User.all
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    if @member.update(member_params)
      redirect_to @members, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

  private

  def set_member
    @member = User.find(params[:id])
  end

  def member_params
    params.require(:user).permit(:email, :full_name)
  end

  def bypass_password_validation
    @member.define_singleton_method(:password_required?) { false }
  end

end
