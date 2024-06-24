class Admin::PostsController < ApplicationController

 def index
    @posts = Post.all
 end

  def show
    @post = Post.find(params[:id])
    @posts = Post.all
    @user = @post.user
    @post_comments = PostComment.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'ユーザー情報を更新しました。'
    else
      @user = @post.user
      render :show
    end
    
    
  def destroy
   @post.destroy
   flash[:notice] = "Post was successfully destroyed."
   redirect_to admin_posts_path
  end
    
  end

  private

  def post_params
    params.require(:post).permit(:user_id,:created_at)
  end




end
