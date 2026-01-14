class ProductsController < ApplicationController
  def index
    if params[:query].present?
      @products = Product.where("LOWER(title) LIKE ?", "%#{params[:query].downcase}%")
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.order(created_at: :desc)
  end
end