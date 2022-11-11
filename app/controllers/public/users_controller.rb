class Public::UsersController < ApplicationController
  before_action :login_user_only
  before_action :baria_user, only: [:edit, :update]

  def my_page
    @user = current_user
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_places = Post.find(favorites)
  end

  def show
    @user = User.find(params[:id])
    @places = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_my_page_path(current_user)
  end

  def suspended
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :profile_image, :nickname, :phone_number, :email)
  end

  def baria_user
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to(user_path(current_user.id))
    end
  end

end
