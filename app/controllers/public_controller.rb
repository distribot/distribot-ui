
class PublicController < ApplicationController

  before_filter :set_active_nav
  def home
  end

  private

  def set_active_nav
    @active_nav = :summary
  end
end
