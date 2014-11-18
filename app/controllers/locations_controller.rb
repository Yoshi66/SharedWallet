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
    @project.locations.build(address: @location.address, photo: @location.photo).save
    redirect_to @project
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
    redirect_to project_path
  end

  def destroy
  end

  private
    def location_params
      params.require(:location).permit(:description, :address, :project_id, :photo)
    end
end

