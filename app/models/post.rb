class Post < ApplicationRecord

  has_one_attached :image

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_managers, dependent: :destroy
  has_many :tags, through: :tag_managers
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  # addressカラムを基準に緯度経度を算出する。
  geocoded_by :address
  # 住所変更時に緯度経度も変更する。
  before_validation :geocode

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @place = Post.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @place = Post.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @place = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @place = Post.where("title LIKE?","%#{word}%")
    else
      @place = Post.all
    end
  end

  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end

end
