class StepsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @step = Step.new(step_params)
    @step.project = @project

    if @step.save
      flash[:notice] =  "Step added successfully"
      redirect_to project_path(@project)
    else
      flash[:notice] = @step.errors.full_messages
      redirect_to project_path(@project)
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @step = Step.find(params[:id])
    if @project.user != current_user && !current_user.admin?
      flash[:notice] =  "Only project owner can update step information"
      redirect_to project_path(@project)
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @step = Step.find(params[:id])
    if @project.user == current_user && @step.update(step_params)
      flash[:notice] =  "Step updated successfully"
      redirect_to project_path(@project)
    else
      flash.now[:notice] = @step.errors.full_messages
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @step = Step.find(params[:id])
    if @project.user == current_user || current_user.admin? 
      @step.destroy
      redirect_to project_path(@project)
    else
      flash[:notice] =  "Only project owner can delete step"
      redirect_to project_path(@project)
    end
  end

  private

  def step_params
    params.require(:step).permit(:step_description, :step_picture)
  end

end
