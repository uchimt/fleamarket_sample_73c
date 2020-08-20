class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  has_one :profile
  has_one :destination
  has_one :credit_card
  has_many :products, dependent: :destroy
  has_many :comments
end
