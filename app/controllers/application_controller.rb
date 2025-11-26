class ApplicationController < ActionController::Base
  helper_method :current_cart

  private

  def current_cart
    # Пытаемся найти корзину по ID, который хранится в сессии
    if session[:cart_id]
      @current_cart ||= Cart.find_by(id: session[:cart_id])
    end

    # Если корзины в сессии нет, или она была удалена из базы, создаем новую
    if @current_cart.nil?
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
    end
    
    @current_cart
  end
end
