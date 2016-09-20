class OrdersController < ApplicationController
  def index
    @orders = Order.where(user_id: params[:user_id])
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user_id
    session[:cart][current_user_id.to_s].each do |key,value|
      product = Product.find(key.to_i)
      @order.products << product
      # @order.products.last.selling_price = product.regular_price
      # @order.products.last.quantity = value
    end

    if @order.save
      redirect_to user_order_path(current_user, @order)
    else
      redirect_to cart_path
    end
  end

  def order_params
    params.require(:order).permit(:shipping_street, :shipping_street_2, :shipping_city, :shipping_state, :shipping_zip_code)
  end
end