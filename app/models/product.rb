class Product < ApplicationRecord
  belongs_to :seller
  has_many :reviews
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :cart_items
  has_many :order_items
  has_many :images, as: :imageable
end