class SessionsController < ApplicationController

  def new
    redirect_to users_path if current_user
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

      flash[:notice] = "Logged in successfully."
      flash[:type] = "success"

      if @user.first_name.length > 0 && @user.last_name.length > 0
        redirect_to @user
      else
        flash[:notice] += " Please setup your profile."
        redirect_to edit_user_path(@user)
      end
    else
      flash[:notice] = "Incorrect username and password."
      flash[:type] = "danger"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_role] = nil
    # session[:cart] = nil
    flash[:notice] = "Logged out successfully."
    flash[:type] = "success"
    redirect_to login_path
  end

end
