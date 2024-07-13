class Admin::PostCommentsController < ApplicationController
  
def index
    @post_comments = PostComment.all
    @users = User.all
    @photo_url = "admin_com.png"
end

def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    redirect_to admin_post_comments_path
end
  
  
end
