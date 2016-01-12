
class HandlerController < ApplicationController
  before_filter :set_active_nav

  def list
    @handlers = [ ]
  end

  def show
  end

  private

  def set_active_nav
    @active_nav = :handlers
  end
end
