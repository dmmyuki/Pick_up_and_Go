class Public::UsersController < ApplicationController
  def my_page
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @places = @user.posts
  end

  def edit
  end

  def update
  end

  def suspended
  end

end
