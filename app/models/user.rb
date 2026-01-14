    class User < ApplicationRecord
      has_secure_password

      validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
      validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

      has_one :seller
  has_one :cart
  has_many :orders
  has_many :reviews
  has_many :favorites
  has_many :favorite_products, through: :favorites, source: :product
end