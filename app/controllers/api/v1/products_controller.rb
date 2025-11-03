class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /api/v1/products
  def index
    @products = Product.all
    render json: @products
  end

  # GET /api/v1/products/:id
  def show
    @product = Product.find(params[:id])
    render json: @product
  end

  # POST /api/v1/products
  def create
    @product = Product.new(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/products/:id
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/products/:id
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    head :no_content
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :stock_quantity, :seller_id)
  end
end