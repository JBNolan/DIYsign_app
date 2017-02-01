class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @comment = Comment.new(comment_params)
    @comment.project = @project
    @comment.user = current_user

    if @comment.save
      flash[:notice] =  "Comment added successfully"
      redirect_to project_path(@project)
    else
      flash[:notice] = @comment.errors.full_messages
      redirect_to project_path(@project)
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      flash[:notice] =  "Only comment owner can update this comment"
      redirect_to project_path(@project)
    end
  end

  def update
    @project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    if @comment.user == current_user && @comment.update(comment_params)
      flash[:notice] =  "Comment updated successfully"
      redirect_to project_path(@project)
    else
      flash.now[:notice] = @comment.errors.full_messages
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to project_path(@project)
    else
      flash[:notice] =  "Only comment owner can delete comment"
      redirect_to project_path(@project)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
