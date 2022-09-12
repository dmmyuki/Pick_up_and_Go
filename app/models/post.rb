class Post < ApplicationRecord

  has_one_attached :image

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tag_managers
  belongs_to :user

  # addressカラムを基準に緯度経度を算出する。
  geocoded_by :address
  # 住所変更時に緯度経度も変更する。
  after_validation :geocode

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

end
