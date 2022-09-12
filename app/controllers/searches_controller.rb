class SearchesController < ApplicationController
  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @places = Post.looks(params[:search], params[:word])
    end
  end
end
