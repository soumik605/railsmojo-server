class Admin::RailsVersionsController < ApplicationController
  layout 'admin'
  before_action :set_rails_version, only: %i[ show edit update destroy ]

  def index
    @rails_versions = RailsVersion.all
    @rails_versions = @rails_versions.paginate(:page => params[:page], :per_page => 10)

    @rails_version = RailsVersion.new
  end

  def show
  end

  def new
    @rails_version = RailsVersion.new
  end

  def edit
  end

  def create
    @rails_version = RailsVersion.new(rails_version_params)
    respond_to do |format|
      if @rails_version.save
        format.html { redirect_to admin_rails_versions_url, notice: "Rails version was successfully created." }
        format.json { render :show, status: :created, location: @rails_version }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rails_version.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rails_version.update(rails_version_params)
        format.html { redirect_to admin_rails_versions_url, notice: "Rails version was successfully updated." }
        format.json { render :show, status: :ok, location: @rails_version }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rails_version.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rails_version.destroy

    respond_to do |format|
      format.html { redirect_to admin_rails_versions_url, notice: "Rails version was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_rails_version
      @rails_version = RailsVersion.find(params[:id])
    end

    def rails_version_params
      params.require(:rails_version).permit(:name, :slug, :is_default, :is_active)
    end
end
