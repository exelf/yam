# coding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_colors
    @current_colors ||= current_user.data.fetch('colors', ["ff0a23", "ffef0a", "1bff0a", "6c0aff"]) if session[:user_id]
  end
  helper_method :current_colors

  def authorize
    redirect_to login_url, alert: "Accès protégé !" if current_user.nil?
  end

end
