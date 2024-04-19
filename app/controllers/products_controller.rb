class ProductsController < ApplicationController
  authorize_resource :company, instance_name: :current_company
  load_and_authorize_resource

  # GET /products
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /products/1
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /products/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # GET /products/1/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # POST /products
  def create
    begin
      @product.company = Company.current_tenant
      success = product.save! 
    rescue StandardError => e
      flash[:alert] = e.message
      success = false
    end

    respond_to do |format|
      if success
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH /products/1
  def update
    begin
      success = product.update!(product_params)
    rescue StandardError => e
      flash[:alert] = e.message
      success = false
    end

    respond_to do |format|
      if success
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
    end
  end

  private

  def product_params
    params.require(:product).permit(:buyer_id, :name, :sale_date, :price, :description, :identification_number)
  end
end
