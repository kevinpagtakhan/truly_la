class Supplier < ActiveRecord::Base
  validates :username, uniqueness: true
  validates :email, uniqueness: true
  has_secure_password
end