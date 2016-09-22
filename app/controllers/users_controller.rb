class UsersController < ApplicationController
  before_filter :loggedin, except: [:new, :create]

  def index
    redirect_to user_path(current_user) unless admin
    if params[:role]
      @users = User.where(:status => true, :role => params[:role])
    else
      @users = User.where(:status => true)
    end
  end

  def show
    if (admin)
      @user = User.find(params[:id])
    else
      @user = User.find(current_user)
    end
  end

  def new
    if !current_user || admin
      @user = User.new
    else
      redirect_to user_path(current_user)
    end
  end

  def create
    @user = User.new(user_params)
    @user.role = 1 unless current_user && admin
    @user.first_name = ""
    @user.last_name = ""
    if @user.save
      if current_user && admin
        redirect_to users_path
      else
        redirect_to login_path
      end
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
    if current_user && admin
      params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation, :shipping_street, :shipping_street_2, :shipping_city, :shipping_state, :shipping_zip_code, :role)
    else
      params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation, :shipping_street, :shipping_street_2, :shipping_city, :shipping_state, :shipping_zip_code)
    end
  end
end
