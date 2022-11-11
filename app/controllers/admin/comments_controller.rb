class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    Comment.find(params[:format]).destroy
    redirect_to admin_post_path(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
