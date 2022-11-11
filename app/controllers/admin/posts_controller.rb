class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @places = Post.all
  end

  def show
    @place = Post.find(params[:id])
    @user = @place.user
    @comment = Comment.new
    @post_tags = @place.tags
  end

  def destroy
    place = Post.find(params[:id])
    place.destroy
    redirect_to admin_posts_path
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:id])
    #検索されたタグに紐づく投稿を表示
    @places = @tag.posts
  end
end
