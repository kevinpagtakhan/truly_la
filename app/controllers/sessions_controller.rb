class SessionsController < ApplicationController

  def new
    redirect_to root_path if current_user
  end

  def create
    @user = User.find_by_username(params[:session][:username])

    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      session[:user_role] = @user.role

      session[:cart] = {} unless session[:cart]
      session[:cart][current_user_id.to_s] = {} unless session[:cart][current_user_id.to_s]

      if session[:cart][current_user_id.to_s].empty?
        session[:cart][current_user_id.to_s] = session[:cart]["0"]
      else
        user = current_user_id

        session[:cart]["0"].each do |key, value|
          session[:cart][user.to_s][key] = 0 unless session[:cart][user.to_s][key]
          session[:cart][user.to_s][key] += value
        end

      end

      session[:cart]["0"] = {}

      redirect_to @user
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_role] = nil
    # session[:cart] = nil
    redirect_to login_path
  end

end
