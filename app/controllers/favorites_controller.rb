class FavoritesController < ApplicationController
  before_action :require_login

  def index
    @favorites = current_user.favorite_products
  end

  def create
    @product = Product.find(params[:product_id])
    current_user.favorite_products << @product unless current_user.favorite_products.include?(@product)
    redirect_back fallback_location: product_path(@product), notice: "Товар добавлен в избранное."
  end

  def destroy
    @favorite = current_user.favorites.find_by(product_id: params[:id])
    @favorite.destroy if @favorite
    redirect_back fallback_location: favorites_path, notice: "Товар удален из избранного."
  end

  private

  def require_login
    unless current_user
      redirect_to sign_in_path, alert: "Пожалуйста, войдите в систему, чтобы управлять избранным."
    end
  end
end
