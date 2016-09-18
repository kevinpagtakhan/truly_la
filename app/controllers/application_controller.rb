class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    role = session[:user_role]

    if role == 'manager'
      @current_user ||= StoreManager.find(session[:user_id]) if session[:user_id]
    elsif role == 'customer'
      @current_user ||= Customer.find(session[:user_id]) if session[:user_id]
    end
  end

  def authorize_manager
    redirect_to sm_login_path unless current_user
  end

end
