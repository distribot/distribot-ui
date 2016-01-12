
class FlowController < ApplicationController
  before_filter :set_active_nav

  def list
    @meta_title = 'Active Flows'
    @flows = Distribot::Flow.active
    render @flows.empty? ? :empty_list : :list
  end

  def create
    @meta_title = 'Create Flow'
    if request.method == 'POST'
      begin
        @flow = Distribot::Flow.create!(JSON.parse(params[:json], symbolize_names: true))
        flash[:notice] = 'Successfully Created'
        redirect_to show_flow_path(flow_id: @flow.id)
      rescue
        flash[:error] = 'There was a problem - please try again'
        begin
          @flow = Distribot::Flow.new(JSON.parse(params[:json]))
        rescue JSON::ParserError => e
          flash[:error] = "Invalid JSON: #{e}"
          @flow_json = params[:json]
          @flow = Distribot::Flow.new()
        end
      end
    else
      @flow = Distribot::Flow.new(
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
    @flow = Distribot::Flow.find(params[:flow_id])
    @meta_title = "View Flow #{@flow.id}"
  end

  def pause
  end

  def resume
  end

  def cancel
  end

  private

  def set_active_nav
    @active_nav = :flows
  end
end
