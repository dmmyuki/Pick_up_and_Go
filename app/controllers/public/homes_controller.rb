class Public::HomesController < ApplicationController
  def top
    @user = current_user
    @places = Post.order('id DESC').limit(4)
    @place_ranks = Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def about
  end
end
