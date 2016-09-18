class User < ActiveRecord::Base
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  has_many :products
  has_secure_password
end
