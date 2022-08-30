class Public::PostsController < ApplicationController
  def new
    @place = Place.new
  end

  def create
    place = Place.new(post_params)
    place.save
    redirect_to post_path(post)
  end

  def index
    @places = Place.all
  end

  def show
    @place = Place.find(params[:id])
  end

  def edit
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :business_hour, :price, :access)
  end
end
