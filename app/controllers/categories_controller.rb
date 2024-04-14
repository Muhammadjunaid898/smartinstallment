class CategoriesController < ApplicationController
  authorize_resource :company, instance_name: :current_company
  load_and_authorize_resource

  # GET /categories
  def index
    respond_to do |format|
      format.html
    end
  end

  # GET /categories/1
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /categories/new
  def new
    respond_to do |format|
      format.html
    end
  end

  # GET /categories/1/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # POST /categories
  def create
    begin
      @category.company = Company.current_tenant
      success = @category.save! 
    rescue StandardError => e
      flash[:alert] = e.message
      success = false
    end

    respond_to do |format|
      if success
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH /categories/1
  def update
    begin
      success = @category.update!(category_params)
    rescue StandardError => e
      flash[:alert] = e.message
      success = false
    end

    respond_to do |format|
      if success
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
