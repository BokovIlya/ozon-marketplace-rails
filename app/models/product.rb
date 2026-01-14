class Product < ApplicationRecord
  belongs_to :seller
  has_many :reviews
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :cart_items
  has_many :order_items
  has_many :images, as: :imageable
  has_many :favorites
  has_many :favorited_by_users, through: :favorites, source: :user

  def average_rating
    return 0 if reviews.empty?
    reviews.average(:rating).round(1)
  end
end