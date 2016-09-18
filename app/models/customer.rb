class Customer < ActiveRecord::Base
  validates :username, uniqueness: true
  has_secure_password
end
