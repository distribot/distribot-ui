
class WorkflowController < ApplicationController
  before_filter :set_active_nav

  def list
  end

  def create
  end

  def submit_create
  end

  def show
  end

  def pause
  end

  def resume
  end

  def cancel
  end

  private

  def set_active_nav
    @active_nav = :workflows
  end
end
