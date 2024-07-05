class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params[:page])
    @photo_url = "users.png"
  end

  def show
    @photo_url = "user.png"
  end

  def edit
  end

  def update
    @photo_url = "user_edit.png"
    if @user.update(user_params)
      flash[:success] = "情報を更新しました。"
      redirect_to admin_user_path(@user)
    else
      flash.now[:danger] = "情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :is_active)
  end
end
