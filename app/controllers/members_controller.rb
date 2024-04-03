class MembersController < ApplicationController
  authorize_resource :company, :instance_name=>:current_company
  load_and_authorize_resource class: User

  def new
  end

  def create
    begin
      @member.company = Company.current_tenant
      @member.new_company_member = true

      if @member.save!
        redirect_to member_path(@member), notice: 'Member was successfuly created.'
      else
        render :new
      end

    rescue => e
      flash[:alert] = "#{e.message}"
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def index
  	respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    if @member.update(member_params)
      redirect_to member_path(@member), notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

  private

  def member_params
    params.require(:user).permit(:email, :full_name)
  end

end
