class RailsVersionsController < ApplicationController
  before_action :set_rails_version, only: %i[ show edit update destroy ]

  # GET /rails_versions or /rails_versions.json
  def index
    @rails_versions = RailsVersion.all
  end

  # GET /rails_versions/1 or /rails_versions/1.json
  def show
  end

  # GET /rails_versions/new
  def new
    @rails_version = RailsVersion.new
  end

  # GET /rails_versions/1/edit
  def edit
  end

  # POST /rails_versions or /rails_versions.json
  def create
    @rails_version = RailsVersion.new(rails_version_params)

    respond_to do |format|
      if @rails_version.save
        format.html { redirect_to rails_version_url(@rails_version), notice: "Rails version was successfully created." }
        format.json { render :show, status: :created, location: @rails_version }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rails_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rails_versions/1 or /rails_versions/1.json
  def update
    respond_to do |format|
      if @rails_version.update(rails_version_params)
        format.html { redirect_to rails_version_url(@rails_version), notice: "Rails version was successfully updated." }
        format.json { render :show, status: :ok, location: @rails_version }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rails_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rails_versions/1 or /rails_versions/1.json
  def destroy
    @rails_version.destroy

    respond_to do |format|
      format.html { redirect_to rails_versions_url, notice: "Rails version was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rails_version
      @rails_version = RailsVersion.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rails_version_params
      params.require(:rails_version).permit(:name, :slug, :is_default, :is_active)
    end
end
