class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  helper_method :logged_in?
  def logged_in?
    !session[:user_id].nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
