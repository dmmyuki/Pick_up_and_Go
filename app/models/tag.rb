class Tag < ApplicationRecord

  has_many :tag_managers, dependent: :destroy
  has_many :posts, through: :tag_managers

end
