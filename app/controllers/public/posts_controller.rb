class Public::PostsController < ApplicationController
before_action :authenticate_user!
before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
def index
  @posts = Post.all
end

def new
  @post = Post.new
end

def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    redirect_to post_path(@post), notice: "You have created post successfully."
    else
     @posts = Post.all
    render:index
    end
end

def show
   @post = Post.find(params[:id])
   @post_comment = PostComment.new
end

def edit
  @post = Post.find(params[:id])
end

def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
     flash[:notice] = "You have updated post successfully."
      redirect_to post_path(@post.id)
    else
      render :edit
    end
end

def destroy
   @post.destroy
   flash[:notice] = "Post was successfully destroyed."
   redirect_to posts_path
end
  
private
  
  def post_params
    params.require(:post).permit(:body)
  end

  def ensure_correct_user
  @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to posts_path
    end
  end
  
end
