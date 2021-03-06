class ProductsController < ApplicationController
  def index
    @products = Product.where(:status => true)
  end

  def inventory
    redirect_to products_path unless admin
    @products = Product.where(:status => true)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    redirect_to products_path unless admin
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path
    else
      redirect_to new_product_path
    end
  end

  def edit
    @product = Product.find(params[:id])
    redirect_to product_path(@product) unless admin
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to products_path
    else
      redirect_to edit_product_path
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.status = false
    if @product.save
      redirect_to products_path
    else
      redirect_to @product
    end
  end

  private

  def product_params
    params.require(:product).permit(:user_id, :sku, :name, :description, :inventory, :wholesale_price, :regular_price, :sale_price, :height, :width, :depth, :weight, :photo)
  end

end
