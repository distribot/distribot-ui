
class AdminController < ApplicationController
  before_filter :authenticate!
  before_filter :set_active_nav

  def home
    @email = current_user.email
  end

  private

  def set_active_nav
    @active_nav = :summary
  end
end
