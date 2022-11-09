class Public::CommentsController < ApplicationController
  def create
    @place = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @place.id
    if @comment.save
      redirect_to post_path(@place)
    else
      render 'public/posts/show'
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
