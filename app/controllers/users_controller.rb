class UsersController < ApplicationController
  def index
    if current_user.role < 3
      redirect_to current_user
    end

    @users = User.where(:status => true)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 1
    if @user.save
      redirect_to login_path
    else
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      redirect_to edit_user_path @user
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.status = false
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation, :shipping_street, :shipping_street_2, :shipping_city, :shipping_state, :shipping_zip_code)
  end
end
