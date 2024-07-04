class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(20)
     @photo_url = "2024-07-05 3.58.39.png"
  end

  def edit
    @user = User.find(params[:id])
     @photo_url = "2024-07-05 3.58.39.png"
  end

  def update
     @photo_url = "2024-07-05 3.58.39.png"
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新に成功しました"
      redirect_to user_path(@user)
    else
      flash[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def index
    @users = User.page(params[:page])
     @photo_url = "2024-07-05 3.58.39.png"
  end

  def unsubscribe
  end

  def withdraw
     @photo_url = "2024-07-05 3.58.39.png"
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def favorites 
     @photo_url = "2024-07-05 3.58.39.png"
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
