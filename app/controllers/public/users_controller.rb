class Public::UsersController < ApplicationController
  def my_page
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @places = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_customer
    @user.update(user_params)
    redirect_to user_my_page_path(current_customer)
  end

  def suspended
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :profile_image, :nickname, :phone_number, :email)
  end

end
