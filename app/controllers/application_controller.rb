class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_user_id, :cart_count, :admin

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user_id
    if current_user != nil
      return current_user.id
    else
      return 0
    end
  end

  def admin
    return current_user.role == 3
  end

  def supplier
    return current_user.role == 2
  end

  def customer
    return current_user.role == 1
  end

  def loggedin
    redirect_to login_path unless current_user
  end

  def cart_count
    sum = 0

    session[:cart] = {} unless session[:cart]

    if session[:cart] && session[:cart][current_user_id.to_s]
      cart = session[:cart][current_user_id.to_s]
      cart.each do |key, value|
        sum += value
      end
    end

    return sum
  end

end
