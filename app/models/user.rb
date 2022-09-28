class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  def fullname
    last_name + first_name
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "ゲスト"
      user.first_name = "ユーザー"
      user.phone_number = "01234567890"
    end
  end

  def self.looks(search, word, nickname)
    if nickname
      # ニックネームが登録されているものを検索
      if search == "perfect_match"
        @user = User.where.not(nickname:nil).where("nickname LIKE?", "#{word}")
      elsif search == "forward_match"
        @user = User.where.not(nickname:nil).where("nickname LIKE?","#{word}%")
      elsif search == "backward_match"
        @user = User.where.not(nickname:nil).where("nickname LIKE?","%#{word}")
      elsif search == "partial_match"
        @user = User.where.not(nickname:nil).where("nickname LIKE?","%#{word}%")
      else
        @user = User.where.not(nickname:nil)
      end
    else
      # ニックネームが登録されていないものを検索
      if search == "perfect_match"
        @user = User.where(nickname:nil).where("first_name LIKE? OR last_name LIKE?", "#{word}", "#{word}")
      elsif search == "forward_match"
        @user = User.where(nickname:nil).where("first_name LIKE? OR last_name LIKE?","#{word}%","#{word}%")
      elsif search == "backward_match"
        @user = User.where(nickname:nil).where("first_name LIKE? OR last_name LIKE?","%#{word}","%#{word}")
      elsif search == "partial_match"
        @user = User.where(nickname:nil).where("first_name LIKE? OR last_name LIKE?","%#{word}%","%#{word}%")
      else
        @user = User.where(nickname:nil)
      end
    end
  end

end
