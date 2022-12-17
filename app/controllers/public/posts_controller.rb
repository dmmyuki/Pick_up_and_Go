class Public::PostsController < ApplicationController
  before_action :login_user_only
  before_action :baria_user, only: [:edit, :update, :destroy]

  def new
    @place = Post.new
    @tag_list = Tag.new
  end

  def create
    @place = Post.new(post_params)
    @place.user_id = current_user.id
    @tag_list = params[:post][:name].split(',')
    if @place.save
      @place.save_tag(@tag_list)
      flash[:notice] = "投稿に成功しました。"
      redirect_to post_path(@place)
    else
      flash[:alert] = "投稿に失敗しました。"
      render:new
    end
  end

  def index
    @places = Post.all
    @tag_list = Tag.all
  end

  def show
    @place = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @place = Post.find(params[:id])
    @tag_list = @place.tags.pluck(:name).join(',')
  end

  def update
    @place = Post.find(params[:id])
    @tag_list = params[:post][:name].split(',')
    if @place.update(post_params)
      # このpost_idに紐づいていたタグを@oldに入れる
      @old_relations = TagManager.where(post_id: @place.id)
      # それらを取り出し、消す。消し終わる
      @old_relations.each do |relation|
        relation.delete
      end
      @place.save_tag(@tag_list)
      redirect_to post_path(@place.id)
    else
      render:edit
    end
  end

  def destroy
    place = Post.find(params[:id])
    place.destroy
    redirect_to posts_path
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:id])
    #検索されたタグに紐づく投稿を表示
    @places = @tag.posts
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :image, :business_hour, :price, :access, :address, :last_name, :first_name, :nickname)
  end

  def baria_user
    @place = Post.find(params[:id])
    @user = @place.user
    redirect_to(posts_path) unless @user == current_user
  end
end
