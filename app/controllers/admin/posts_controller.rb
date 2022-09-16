class Admin::PostsController < ApplicationController
  def index
    @places = Post.all
  end

  def show
    @place = Post.find(params[:id])
    @user = @place.user
    @comment = Comment.new
  end

  def destroy
    place = Post.find(params[:id])
    place.destroy
    redirect_to admin_posts_path
  end
end
