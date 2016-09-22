class User < ActiveRecord::Base
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :orders
  has_secure_password
end
