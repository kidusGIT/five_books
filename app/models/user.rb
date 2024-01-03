class User < ApplicationRecord

  has_many :books, dependent: :destroy

  has_many :carts, dependent: :destroy
  has_many :books, through: :carts

  validates :username, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
