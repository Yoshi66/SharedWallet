class LocationsController < ApplicationController

  def new
    @location = Location.new
    @project = Project.find(params[:project_id])
  end

  def index
  end

  def show
  end

  def edit
    @project = Project.find(params[:project_id])
    @location = Location.find(params[:id])
  end

  def create
    @project = Project.find(params[:project_id])
    @location = Location.new(location_params)
    @country = Carmen::Country.coded(project_params[:country_code])
    @state = @country.subregions.coded(project_params[:state_code])
    @project.locations.build(address: "#{location_params[:address]}, #{@state.name}, #{@country.name}", photo: @location.photo, user_id: current_user.id).save
    redirect_to @project
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
    redirect_to project_path
  end

  def destroy
    @project = Project.find(params[:project_id])
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to @project
  end

  private
    def location_params
      params.require(:location).permit(:description, :address, :project_id, :photo, :user_id)
    end

    def project_params
      params.require(:project).permit(:content, :user_id, :place, :country_code, :state_code)
    end
end

