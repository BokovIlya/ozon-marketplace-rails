# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# --- Очистка базы данных ---
puts "Очистка базы данных..."
Review.destroy_all
Payment.destroy_all
OrderItem.destroy_all
CartItem.destroy_all
ProductCategory.destroy_all
Image.destroy_all
Order.destroy_all
Cart.destroy_all
Product.destroy_all
Category.destroy_all
Seller.destroy_all
User.destroy_all

# --- Создание пользователей и продавца ---
puts "Создание пользователей и продавца..."
seller_user = User.create!(email: 'seller@example.com', password: 'password', password_confirmation: 'password')
buyer_user = User.create!(email: 'buyer@example.com', password: 'password', password_confirmation: 'password')
seller = Seller.create!(user: seller_user, store_name: 'Tech Store')

# --- Создание категорий ---
puts "Создание категорий..."
electronics = Category.create!(name: 'Электроника')
books = Category.create!(name: 'Книги')
smartphones = Category.create!(name: 'Смартфоны')
appliances = Category.create!(name: 'Бытовая техника')

# --- Создание товаров ---
puts "Создание товаров..."
product1 = Product.create!(title: 'СуперСмартфон 2000', description: 'Лучший телефон на рынке.', price: 59990.00, seller: seller, categories: [electronics, smartphones])
product2 = Product.create!(title: 'Ноутбук "Профессионал"', description: 'Идеальный выбор для работы и учебы.', price: 85000.00, seller: seller, categories: [electronics])
product3 = Product.create!(title: 'Научно-фантастический роман "Звездный Путник"', description: 'Захватывающее путешествие.', price: 850.50, seller: seller, categories: [books])
product4 = Product.create!(title: 'Кофемашина "Утренний Бариста"', description: 'Начните свой день с идеального эспрессо.', price: 12500.00, seller: seller, categories: [appliances])
product5 = Product.create!(title: 'Беспроводные наушники "Аудиофил"', description: 'Кристально чистый звук.', price: 7990.00, seller: seller, categories: [electronics, smartphones])
product6 = Product.create!(title: 'Энциклопедия "Мир в картинках"', description: 'Большая иллюстрированная энциклопедия.', price: 2100.00, seller: seller, categories: [books])

# --- Создание корзины, заказа, и т.д. ---
puts "Создание связанных данных (корзина, заказ, платеж, изображение)..."
cart = Cart.create!(user: buyer_user)
CartItem.create!(cart: cart, product: product1, quantity: 1)
CartItem.create!(cart: cart, product: product5, quantity: 2)

order = Order.create!(user: buyer_user, total_amount: (product3.price + product4.price), status: 'completed')
OrderItem.create!(order: order, product: product3, quantity: 1, price: product3.price)
OrderItem.create!(order: order, product: product4, quantity: 1, price: product4.price)
Payment.create!(order: order, amount: order.total_amount, status: 'paid', payment_method: 'credit_card')
Image.create!(imageable: product1, url: 'https://example.com/smartphone.jpg')

# --- Создание отзывов ---
puts "Создание отзывов..."
comments = ["Отличный товар!", "Неплохо, но могло быть и лучше.", "Великолепно! 10/10.", "Хорошее соотношение цена/качество.", "Именно то, что я искал."]
all_products = [product1, product2, product3, product4, product5, product6]

all_products.each do |product|
  3.times do
    Review.create!(
      product: product,
      user: buyer_user,
      rating: rand(3..5),
      comment: comments.sample
    )
  end
end

# --- Финальный отчет ---
puts "\nЗаполнение базы данных завершено!"
puts "---------------------------------"
puts "Создано пользователей: #{User.count}"
puts "Создано продавцов: #{Seller.count}"
puts "Создано категорий: #{Category.count}"
puts "Создано товаров: #{Product.count}"
puts "Создано корзин: #{Cart.count} с #{CartItem.count} позициями"
puts "Создано заказов: #{Order.count} с #{OrderItem.count} позициями"
puts "Создано платежей: #{Payment.count}"
puts "Создано отзывов: #{Review.count}"
puts "Создано изображений: #{Image.count}"
