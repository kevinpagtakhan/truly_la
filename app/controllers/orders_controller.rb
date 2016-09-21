class OrdersController < ApplicationController
  before_filter :loggedin

  def index
    if admin && current_user_id == params[:user_id].to_i
      if params[:shipment_status]
        @orders = Order.where(shipment_status: params[:shipment_status])
        @orders = @orders.select do |order|
          order.user.role != 3
        end
      elsif params[:user] && params[:user] == "admin"
        @orders = Order.where(user_id: current_user_id)
      else
        @orders = Order.where.not(user_id: current_user_id)
      end
    elsif supplier
      @orders = Order.all
      if params[:from] && params[:from] == "admin"
        @orders = @orders.select do |order|
          order.user.role == 3 && order.products.first.user.id == current_user_id
        end
      else
        @orders = Order.where(user_id: current_user_id)
      end
    else
      @orders = Order.where(user_id: params[:user_id])
    end
  end

  def show
    if admin || current_user.id == params[:user_id].to_i
      @order_products = OrderProduct.where(order_id: params[:id])
      @order = @order_products.first.order
    else
      redirect_to user_orders_path(current_user)
    end
  end

  def new
    @order = Order.new
  end

  def create
    if current_user.role < 3
      @order = Order.new(order_params)
      @order.user_id = current_user_id

      @order.shipment_status = "pending"
      @order.payment_status = "complete"
      session[:cart][current_user_id.to_s].each do |key,value|
        product = Product.find(key.to_i)
        @order.products << product

        @order.order_products.last.selling_price = product.regular_price
        @order.order_products.last.quantity = value
      end

      if @order.save
        session[:cart][current_user_id.to_s] = {}
        redirect_to user_order_path(current_user, @order)
      else
        redirect_to cart_path
      end
    else
      # separate cart into different groups depending on supplier
      admin_cart = {}
      session[:cart][current_user_id.to_s].each do |key,value|
        supplier = Product.find(key.to_i).user.username
        admin_cart[supplier] = {} unless admin_cart[supplier]
        admin_cart[supplier][key] = value
      end
      # generate order from multiple carts
      admin_cart.each do |key, value|
        @order = Order.new(order_params)
        @order.user_id = current_user_id

        @order.shipment_status = "pending"
        @order.payment_status = "pending"
        admin_cart[key].each do |k, v|
          # add to order
          product = Product.find(k.to_i)
          @order.products << product

          @order.order_products.last.selling_price = product.regular_price
          @order.order_products.last.quantity = v
          # save order
          @order.save
          @order.order_products.last.save
        end
      end
      session[:cart][current_user_id.to_s] = {}
      redirect_to user_orders_path(current_user)
    end
  end

  def shipped
    @order = Order.find(params[:id])
    @order.shipment_status = "complete"
    if @order.save
      redirect_to user_order_path @order.user, @order
    end
  end

  def paid
    @order = Order.find(params[:id])
    @order.payment_status = "complete"
    if @order.save
      redirect_to user_order_path @order.user, @order
    end
  end

  def order_params
    params.require(:order).permit(:shipping_street, :shipping_street_2, :shipping_city, :shipping_state, :shipping_zip_code)
  end
end
