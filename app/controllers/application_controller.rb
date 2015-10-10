class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  helper_method :current_user
  helper_method :logged_in?
end
