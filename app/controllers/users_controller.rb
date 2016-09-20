class UsersController < ApplicationController
  before_filter :loggedin, except: [:new, :create]

  def index
    redirect_to user_path(current_user) unless admin

    @users = User.where(:status => true)
  end

  def show
    if (admin)
      @user = User.find(params[:id])
    else
      @user = User.find(current_user)
    end
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
    if (admin)
      @user = User.find(params[:id])
    else
      @user = User.find(current_user)
    end
  end

  def update
    if (admin)
      @user = User.find(params[:id])
    else
      @user = User.find(current_user)
    end

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
