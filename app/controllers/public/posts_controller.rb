class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html do
        @posts = Post.page(params[:page]).per(20).order(created_at: :desc)
      end
      format.json do
        @posts = Post.all
      end
      @photo_url = "posts.png"
    end
  end

  def new
    @post = Post.new
    @photo_url = "new.png"
  end

  def create
    @photo_url = "posts.png"
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "投稿に成功しました"
    else
      flash[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post.increment!(:view_count)
    @photo_url = "post.png"
  end

  def edit
    @post = Post.find(params[:id])
    @photo_url = "post_edit.png"
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
     @photo_url = "postedit.png"
    if @post.update(post_params)
      flash[:notice] = "更新に成功しました"
      redirect_to post_path(@post.id)
    else
      flash[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
     @photo_url = "2024-07-05 3.58.39.png"
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "削除に成功しました"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :address, :latitude, :longitude)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to posts_path
    end
  end
end
