class Public::HomesController < ApplicationController
  def top
    @user = current_user
    @places = Post.order('id DESC').limit(4)
  end

  def about
  end
end
