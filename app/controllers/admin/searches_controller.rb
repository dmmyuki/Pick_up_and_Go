class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word], true)
      @users2 = User.looks(params[:search], params[:word], false)
    else
      @places = Post.looks(params[:search], params[:word])
    end
  end
end
