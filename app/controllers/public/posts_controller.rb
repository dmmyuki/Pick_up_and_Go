class Public::PostsController < ApplicationController
  def new
    @place = Post.new
  end

  def create
    place = Post.new(post_params)
    place.save
    redirect_to post_path(place)
  end

  def index
    @places = Post.all
  end

  def show
    @place = Post.find(params[:id])
  end

  def edit
    @place = Post.find(params[:id])
  end

  def update
    place = Post.find(params[:id])
    place.update(post_params)
    redirect_to post_path(place.id)
  end

  def destroy
    place = Post.find(params[:id])
    place.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :business_hour, :price, :access, :address)
  end
end
