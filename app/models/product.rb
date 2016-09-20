class Product < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :sku, uniqueness: true
  belongs_to :user
  has_many :reviews
  has_many :order_products
  has_many :orders, through: :order_products
end
