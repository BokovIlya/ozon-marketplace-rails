class CartItemsController < ApplicationController
  def create
    # Находим товар, который хотим добавить
    product = Product.find(params[:product_id])

    # Ищем, есть ли этот товар уже в корзине
    @cart_item = current_cart.cart_items.find_by(product: product)

    if @cart_item
      # Если товар уже есть, просто увеличиваем количество
      @cart_item.increment(:quantity)
    else
      # Если товара нет, создаем новую запись с количеством 1
      @cart_item = current_cart.cart_items.build(product: product, quantity: 1)
    end

    if @cart_item.save
      redirect_to cart_path, notice: "#{product.title} был добавлен в корзину."
    else
      redirect_to product_path(product), alert: "Не удалось добавить товар в корзину."
    end
  end
end
