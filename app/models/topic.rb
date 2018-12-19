class Topic < ApplicationRecord

  validates :image, presence: true
  validates :description, presence: true
  validates :user_id, presence: true

  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :favorites
  has_many :comments
  has_many :favorite_users, through: :favorites, source: 'user'

end
