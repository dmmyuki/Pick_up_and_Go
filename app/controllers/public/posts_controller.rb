class Public::PostsController < ApplicationController
  def new
    @place = Post.new
  end

  def create
    place = Post.new(post_params)
    place.save
    redirect_to post_path(post)
  end

  def index
    @places = Post.all
  end

  def show
    @place = Post.find(params[:id])
  end

  def edit
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :business_hour, :price, :access, :address)
  end
end
