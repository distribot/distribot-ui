
class WorkflowController < ApplicationController
  before_filter :set_active_nav

  def list
    @meta_title = 'Active Flows'
    @workflows = Distribot::Workflow.active
    render @workflows.empty? ? :empty_list : :list
  end

  def create
    @meta_title = 'Create Flow'
    if request.method == 'POST'
      begin
        @workflow = Distribot::Workflow.create!(JSON.parse(params[:json], symbolize_names: true))
        flash[:notice] = 'Successfully Created'
        redirect_to show_workflow_path(workflow_id: @workflow.id)
      rescue
        flash[:error] = 'There was a problem - please try again'
        begin
          @workflow = Distribot::Workflow.new(JSON.parse(params[:json]))
        rescue JSON::ParserError => e
          flash[:error] = "Invalid JSON: #{e}"
          @workflow_json = params[:json]
          @workflow = Distribot::Workflow.new()
        end
      end
    else
      @workflow = Distribot::Workflow.new(
        phases: [
          {
            name: "start",
            is_initial: true,
            transitions_to: "finish"
          },
          {
            name: "finish",
            is_final: true,
          }
        ]
      )
    end
  end

  def show
    @workflow = Distribot::Workflow.find(params[:workflow_id])
    @meta_title = "View Flow #{@workflow.id}"
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
