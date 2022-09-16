class Public::PostsController < ApplicationController
  def new
    @place = Post.new
  end

  def create
    place = Post.new(post_params)
    place.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if place.save
      place.save_tag(tag_list)
      redirect_to post_path(place)
    else
      render:new
    end
  end

  def index
    @places = Post.all
    @tag_list = Tag.all
  end

  def show
    @place = Post.find(params[:id])
    @user = @place.user
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def edit
    @place = Post.find(params[:id])
    @tag_list = @place.tags.pluck(:name).join(',')
  end

  def update
    place = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if place.update(post_params)
      place.save_tag(tag_list)
      redirect_to post_path(place.id)
    else
      render:edit
    end
  end

  def destroy
    place = Post.find(params[:id])
    place.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :business_hour, :price, :access, :address, :last_name, :first_name, :nickname, :name)
  end
end
