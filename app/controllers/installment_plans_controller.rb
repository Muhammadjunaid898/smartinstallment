class InstallmentPlansController < ApplicationController
  authorize_resource :company, instance_name: :current_company
  load_and_authorize_resource find_by: :sequence_num, through: :current_company

  # GET /installment_plans
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /installment_plans/1
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /installment_plans/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # GET /installment_plans/1/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # POST /installment_plans
  def create
    begin
      @installment_plan.company = Company.current_tenant
      @installment_plan.save!
    rescue StandardError => e
      flash[:alert] = e.message
    end
    
    respond_to do |format|
      if @installment_plan.persisted?
        format.html { redirect_to installment_plan_path(@installment_plan), notice: "Installment plan was successfully created." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH /installment_plans/1
  def update
    respond_to do |format|
      if @installment_plan.update(installment_plan_params)
        format.html { redirect_to installment_plan_url(@installment_plan), notice: "Installment plan was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /installment_plans/1
  def destroy
    @installment_plan.destroy

    respond_to do |format|
      format.html { redirect_to installment_plans_url, notice: "Installment plan was successfully destroyed." }
    end
  end

  private

  def installment_plan_params
    params.require(:installment_plan).permit(
      :booking_amount,
      :allocation_amount,
      :biannual_payment,
      :monthly_payment,
      :quarterly_payment,
      :no_of_monthly_payments,
      :no_of_biannual_or_quarterly_payments
    )
  end
end
