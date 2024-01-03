class Book < ApplicationRecord

  belongs_to :user, foreign_key: 'user_id'
  has_one_attached :image, dependent: :destroy
  validates :year, :title, :author, presence: true

  has_many :carts, dependent: :destroy
  has_many :users, through: :carts

  # def image_url
  #   Rails.application.routes.url_helpers.url_for(image) if image.attached?
  # end

end
