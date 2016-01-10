class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  config.whitelisted_ips = '0.0.0.0'

  def sign_in(user)
    if user
      session[:user_id] = user.id
    end
  end

  protected
  include ApplicationHelper

  def authenticate!
    unless signed_in?
      flash[:error] = "You must first sign in before requesting that page"
      return redirect_to :signin
    end
  end
end
