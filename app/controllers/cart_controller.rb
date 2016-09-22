class CartController < ApplicationController
  def index
    cart_hash = session[:cart][current_user_id.to_s]
    @cart = []

    cart_hash.each do |key, value|
      @cart.push([Product.find(key), value])
    end
  end

  def add_item
    user = 0
    user = current_user.id if current_user

    session[:cart][user.to_s] = {} unless session[:cart][user.to_s]

    session[:cart][user.to_s][params[:id].to_s] = 0 unless session[:cart][user.to_s][params[:id].to_s]
    session[:cart][user.to_s][params[:id].to_s] += 1

    flash[:notice] = Product.find(params[:id]).name + " was added to your cart."
    flash[:type] = "info"

    redirect_to :back
  end

  def delete_item
    user = current_user_id

    session[:cart][user.to_s].delete(params[:id].to_s)

    flash[:notice] = Product.find(params[:id]).name + " was deleted from your cart."
    flash[:type] = "warning"
    redirect_to cart_path
  end

  def checkout

  end

end
