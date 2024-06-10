class Public::UsersController < ApplicationController

def show
  @user = User.find(params[:id])
  @posts = @user.posts
  @post = Post.new
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
  @user = current_user
  @users = User.all
  @post =Post.new
  @posts = Post.all
end

 private

  def user_params
    params.require(:user).permit(:name )
  end



end
