class Api::V1::OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  # GET /api/v1/orders
  def index
    @orders = Order.all
    render json: @orders
  end

  # GET /api/v1/orders/:id
  def show
    @order = Order.find(params[:id])
    render json: @order
  end

  # POST /api/v1/orders
  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:status, :shipping_address, :total_price, :user_id)
  end
end