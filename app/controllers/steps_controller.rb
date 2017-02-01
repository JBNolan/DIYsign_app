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

  private

  def step_params
    params.require(:step).permit(:step_description, :step_picture)
  end

end
