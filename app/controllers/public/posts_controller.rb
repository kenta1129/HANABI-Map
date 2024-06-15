class Public::PostsController < ApplicationController
  
def index
  @user = current_user
  @post = Post.new
  @posts = Post.all
end

def new
  @post = Post.new
end

def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    flash[:notice] = "You have created post successfully."
    redirect_to post_path(@post)
    
    else
     @user = current_user
     @posts = Post.all
    render:index
    end
end

def show
   @post = Post.find(params[:id])
   @user = @post.user
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
   @post = Post.find(params[:id])
   @post.destroy
   flash[:notice] = "Post was successfully destroyed."
   redirect_to posts_path
end
  
private
  
  def post_params
    params.require(:post).permit(:body)
  end

  
  
end
