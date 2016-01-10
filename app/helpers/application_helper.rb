module ApplicationHelper

  def signed_in?
    session[:user_id] ? true : false
  end

  def current_user
    return nil unless session[:user_id]
    User.find(session[:user_id]) rescue nil
  end

  def active_nav(name)
    @active_nav ||= :home
    @active_nav == name ? 'active red inverted' : ''
  end
end
