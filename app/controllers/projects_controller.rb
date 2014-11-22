class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit,:update, :destroy]
  before_action :authenticate_user!, only: [:index]


  def index
    @projects = Project.paginate(page: params[:page])
  end

  def show
    @user = @project.user
    @location = Location.find(params[:id])
    @locations = @project.locations.all
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.description
    end
    @hashroute =[]
     @project.locations.each do |location|
      @hashroute << { :lat => location.latitude, :lng => location.longitude}
      @hashroute << { :lat => location.latitude, :lng => location.longitude}
     end

    respond_to do |format|
          format.html {render :show}
          format.json { head :ok}
    end

  end

  def subregion_options
    render partial: 'subregion_select'
  end

  # GET /projects/new
  def new
    @project = Project.new
    logger.debug("hello")
    @location = Location.new
  end


  def home
  end


  def help
  end


  def edit
    @location = Location.find(params[:id])
    @project = Project.find(params[:id])
  end

  def pin
    @project = Project.new
    @location = Location.new
  end

  def createpin
    @project = Project.find(params[:id])
    @location = Location.new(location_params)
    @project.locations.build(address: @location.address, photo: @location.photo).save

    redirect_to project_path
  end

  def editpin
    @project = Project.find(params[:id])
    @location = Location.find(params[:id])
  end

  def updatepin
    @location = Location.find(params[:id])
    @location.update(location_params)
    redirect_to project_path
  end

  def create
    @project = current_user.projects.build(project_params)#Project.new(project_params)
    @country = Carmen::Country.coded(project_params[:country_code])
    @state = @country.subregions.coded(project_params[:state_code])
    @location = @project.locations.build(address: "#{location_params[:address]}, #{@state.name}, #{@country.name}", description: location_params[:description], photo: location_params[:photo])
    @location.user = current_user
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @location = Location.find(params[:id])
    respond_to do |format|
      if @project.update(project_params)
        @location.update(location_params)
        redirect_to @project
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def self.method

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:content, :user_id, :place, :country_code, :state_code)
    end

    def location_params
      params.require(:location).permit(:description, :address, :project_id, :photo)
    end

end
