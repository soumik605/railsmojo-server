class Admin::CategoriesController < ApplicationController
  layout 'admin'
  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.all
    @categories = @categories.paginate(:page => params[:page], :per_page => 10)

    @category = Category.new
    @rails_versions = RailsVersion.all
    @rails_versions = @rails_versions.active if @rails_versions.count != 0
  end

  def show
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_url, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_url, notice: "Category was successfully updated." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to admin_categories_url, notice: "Category was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:rails_version_id, :name, :slug, :position, :is_active, :description, :parent_category_id)
    end
end
