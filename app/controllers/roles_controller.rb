class RolesController < ApplicationController
load_and_authorize_resource
 
  def index
    @user = User.find(params[:user_id])
    @all_roles = Role.find(:all)
  end
 
  def update
    @user = User.find(params[:user_id])
    @role = Role.find(params[:id])
    unless @user.role?(@role.name)
      @user.roles << @role
    end
    redirect_to edit_user_path(@user)
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @role = Role.find(params[:id])
    if @user.role?(@role.name)
      @user.roles.delete(@role)
    end
    redirect_to edit_user_path(@user)
  end
end
