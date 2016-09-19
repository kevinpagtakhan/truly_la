class SessionsController < ApplicationController

  def new
    redirect_to root_path if current_user
  end

  def create
    @user = User.find_by_username(params[:session][:username])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      session[:user_role] = @user.role
      redirect_to @user
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_role] = nil
    session[:cart] = nil
    redirect_to login_path
  end

end
