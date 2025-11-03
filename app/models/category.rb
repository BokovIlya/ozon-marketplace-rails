class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories
  has_many :images, as: :imageable

  # Для связи "родитель-потомок"
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: 'parent_id'
end