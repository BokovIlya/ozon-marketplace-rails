class OrdersController < ApplicationController
  def create
    # Начинаем транзакцию, чтобы все операции были выполнены успешно, либо ни одна
    ActiveRecord::Base.transaction do
      # Создаем новый заказ. Пока без пользователя, так как у нас его нет
      @order = Order.create!(
        total_amount: current_cart.cart_items.sum { |item| item.product.price * item.quantity },
        status: 'pending' # Статус "в ожидании"
      )

      # Переносим каждый товар из корзины в заказ
      current_cart.cart_items.each do |cart_item|
        OrderItem.create!(
          order: @order,
          product: cart_item.product,
          quantity: cart_item.quantity,
          price: cart_item.product.price
        )
      end

      # Очищаем корзину после создания заказа
      current_cart.cart_items.destroy_all
      session[:cart_id] = nil # Опционально: сбрасываем сессию, чтобы создалась новая корзина
    end
    
    # Перенаправляем на страницу "Спасибо" (которую мы скоро создадим)
    redirect_to order_path(@order), notice: "Ваш заказ успешно создан!"
  rescue ActiveRecord::RecordInvalid => e
    # Если что-то пошло не так, возвращаем пользователя в корзину с ошибкой
    redirect_to cart_path, alert: "Не удалось создать заказ: #{e.message}"
  end

  def show
    @order = Order.find(params[:id])
  end
end
