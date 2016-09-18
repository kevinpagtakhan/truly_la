class SessionsController < ApplicationController

  def sm_new
    redirect_to root_path if current_user
  end

  def sm_create
    @user = StoreManager.find_by_username(params[:session][:username])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      session[:user_role] = 'manager'
      redirect_to @user
    else
      redirect_to sm_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_role] = nil
    redirect_to sm_login_path
  end

  private

  # def session_params
  #   params.require(:session).permit(:username, :password)
  # end
end
