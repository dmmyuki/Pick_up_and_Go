class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to admin_user_path(user.id)
  end

  def suspended
    user = User.find(params[:user_id])
    user.update(suspended: true)
    reset_session
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :nickname, :phone_number)
  end
end
