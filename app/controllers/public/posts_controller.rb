class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to post_path(post)
  end

  def index
  end

  def show
  end

  def edit
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :business_hour, :price, :access)
  end
end
