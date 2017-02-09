class ProjectsController < ApplicationController

  def index
    if params[:search]
      @projects = Project.search(params[:search])
    else
      @projects = Project.all.order("created_at DESC")
    end
  end

  def show
    @project = Project.find(params[:id])
    @step = Step.new
    @steps = @project.steps
    @comment = Comment.new
    @comments = @project.comments

    @store_type = type_of_store(@project.category)
    key = ENV["API_KEY"]
    @stores = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{current_user.latitude},#{current_user.longitude}&radius=50000&type=#{@store_type}&key=#{key}")
  end

  def new
    @project = Project.new
    @categories = Project::CATEGORIES
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      flash[:notice] =  "Project created successfully!"
      redirect_to project_path(@project)
    else
      flash.now[:notice] = @project.errors.full_messages
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    if @project.user == current_user || current_user.admin?
      @categories = Project::CATEGORIES
    else
      flash[:notice] =  "Only project owner can update project information"
      redirect_to project_path(@project)
    end
  end

  def update
    @project = Project.find(params[:id])
    @categories = Project::CATEGORIES
    if @project.user.id == current_user.id && @project.update(project_params)
      flash[:notice] =  "Project updated successfully"
      redirect_to project_path(@project)
    else
      flash.now[:notice] = @project.errors.full_messages
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.user == current_user || current_user.admin?
      @project.destroy
      flash[:notice] =  "Project deleted sucessfully"
      redirect_to projects_path
    else
      flash[:notice] =  "Only project owner or Admin can delete project"
      redirect_to project_path(@project)
    end
  end

  def categories
    @projects = Project.where(category: params[:id])
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :supplies, :project_photo, :category)
  end

  def type_of_store(category)
    if category == 'Home Improvement'
      return 'hardware_store'
    elsif category == 'Crafting'
      return 'home_goods_store'
    else
      return 'shopping_mall'
    end
  end
end
