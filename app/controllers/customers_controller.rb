class CustomersController < ApplicationController
  def index
    @customer = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      session[:user_id] = @customer.id
      session[:user_role] = 'customer'
      redirect_to @customer
    else
      redirect_to new_customer_path
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])

    if @customer.update(customer_params)
      redirect_to @customer
    else
      redirect_to edit_customer_path @customer
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:username, :email, :first_name, :last_name, :shipping_street, :shipping_street_2, :shipping_city, :shipping_state, :shipping_zip_code, :password, :password_confirmation)
  end
end
