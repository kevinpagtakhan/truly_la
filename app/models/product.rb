class Product < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :sku, uniqueness: true
  belongs_to :user
  has_many :reviews
end