
class WorkerController < ApplicationController
  before_filter :set_active_nav

  def list
    @workers = [ ]
  end

  def show
  end

  private

  def set_active_nav
    @active_nav = :workers
  end
end
