class Post < ApplicationRecord

  has_many :favorites
  has_many :comments
  has_many :tag_managers

end
