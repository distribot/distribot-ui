module ApplicationHelper
  def active_nav(name)
    @active_nav ||= :home
    @active_nav == name ? 'active red inverted' : ''
  end
end
