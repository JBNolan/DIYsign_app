class UsersController < ApplicationController
  def index
    if current_user.admin?
      @users = User.all
    else
      flash[:notice] =  "Only Admin can see this page"
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
    @projects = Project.where(user_id: @user.id)
    @date = @user.created_at.to_date.strftime("%B %d, %Y")
  end

  def destroy
    @deleteuser = User.find(params[:id])
    if current_user.admin?
      @deleteuser.projects.destroy_all
      @deleteuser.comments.destroy_all
      @deleteuser.destroy
      redirect_to users_path
    else
      flash[:notice] =  "Only Admin can delete users"
      redirect_to users_path
    end
  end

end
