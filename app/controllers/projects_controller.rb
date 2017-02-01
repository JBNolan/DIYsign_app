class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @step = Step.new
    @steps = @project.steps
    @comment = Comment.new
    @comments = @project.comments
  end

  def new
    @project = Project.new
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
    if @project.user.id != current_user.id
      flash[:notice] =  "Only project owner can update project information"
      redirect_to project_path(@project)
    end
  end

  def update
    @project = Project.find(params[:id])
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
    if @project.user.id == current_user.id
      @project.destroy
      flash[:notice] =  "Project deleted sucessfully"
      redirect_to projects_path
    else
      flash[:notice] =  "Only project owner or Admin can delete project"
      redirect_to project_path(@project)
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :supplies, :picture)
  end
end
