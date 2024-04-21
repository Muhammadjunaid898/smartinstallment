class MembersController < ApplicationController
  authorize_resource :company, instance_name: :current_company
  load_and_authorize_resource class: User

  #GET /members/new
  def new
    respond_to do |format|
      format.html
    end
  end

  #POST /members
  def create
    begin
      @member.company = Company.current_tenant
      @member.created_by_id = @current_user.id
      @member.new_company_member = true
      success = @member.save! 
    rescue StandardError => e
      flash[:alert] = e.message
      success = false
    end

    respond_to do |format|
      if success
        format.html { redirect_to member_path(@member), notice: 'Member was successfuly created.' }
      else
        format.html { render :new }
      end
    end
  end

  #GET /members/id
  def show
    respond_to do |format|
      format.html
    end
  end

  #GET /members
  def index
    respond_to do |format|
      format.html
    end
  end

  #GET /members/id/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  #PATCH /members/id
  def update
    begin
      success = @member.update!(member_params)   
    rescue StandardError => e
      flash[:alert] = e.message
      success = false
    end
    respond_to do |format|
      if success
        format.html {  redirect_to member_path(@member), notice: 'Member was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  #DELETE /members/id
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully deleted.' }
    end
  end

  private

  def member_params
    params.require(:user).permit(:email, :full_name)
  end

end
