class Admin::PostsController < ApplicationController
# before_action :authenticate_admin!


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
  end
    
  def destroy
    
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post was successfully destroyed."
    redirect_to admin_posts_path
   
  end
    

  private

  def post_params
    params.require(:post).permit(:title,:body)
  end




end
