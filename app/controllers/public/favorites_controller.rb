class Public::FavoritesController < ApplicationController
  def create
    place = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: place.id)
    favorite.save
    redirect_to post_path(place)
  end

  def destroy
    place = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: place.id)
    favorite.destroy
    redirect_to post_path(place)
  end
end
