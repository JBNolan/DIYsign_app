class UsersController < ApplicationController
  def index
    if current_user.admin?
      @users = User.all
    else
      flash[:notice] =  "Only Admin can see this page"
      redirect_to root_path
    end
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
