class Public::UsersController < ApplicationController

def show
  @user = User.find(params[:id])
  @posts = @user.posts
end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
     flash[:notice] = "You have updated user successfully."
   redirect_to user_path(@user)
  else
    render :edit
  end
end

def index
  @users = User.all
end

def unsubscribe
    
end

def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session 
    flash[:notice]="退会処理を実行いたしました"
    redirect_to root_path
end

 private

  def user_params
    params.require(:user).permit(:name, :profile_image )
  end



end
