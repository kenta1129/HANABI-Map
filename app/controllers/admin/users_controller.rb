class Admin::UsersController < ApplicationController

  # before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "情報を更新しました。"
      redirect_to admin_user_path(@user)
    else
      flash.now[:danger] = "情報の更新に失敗しました。"
      render :edit
    end
    
  def destroy
    @admin_user = User.find(params[:id])
    @admin_user.destroy
    redirect_to admin_users_path
  end
    
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:email, :is_active)
  end
  def user_restore
    @admin_user = User.deleted.find(params[:id]).restore
    redirect_to admin_users_path
  end


end
