class Admin::PostsController < ApplicationController
before_action :authenticate_admin!


  def index
    @posts = Post.page(params[:page])
    @photo_url = "posts.png"
  end

  def show
    @post = Post.find(params[:id])
    @posts = Post.page(params[:page])
    @user = @post.user
    @post_comments = PostComment.all
    @photo_url = "post.png"
  end

  def update
    @photo_url = "post_edit.png"
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
    flash[:notice] = "投稿の削除に成功しました。."
    redirect_to admin_posts_path
   
  end
    

  private

  def post_params
    params.require(:post).permit(:title,:body)
  end




end
