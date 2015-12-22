require 'spec_helper'

describe WorkflowController do
  describe '#list' do
    context 'when there' do
      context 'are workflows' do
        before do
          expect(Distribot::Workflow).to receive(:active) do
            workflow = double('workflow')
            [ workflow ]
          end
          get :list
        end
        it 'lists them' do
          expect(response).to render_template :list
        end
      end
      context 'are no workflows' do
        before do
          expect(Distribot::Workflow).to receive(:active){ [] }
          get :list
        end
        it 'shows the empty state' do
          expect(response).to render_template :empty_list
        end
      end
    end
  end
  describe '#show' do
    context 'when the workflow exists' do
      before do
        @workflow = Distribot::Workflow.new(id: 'xxx')
        expect(Distribot::Workflow).to receive(:find).with('xxx'){ @workflow }
        get :show, workflow_id: @workflow.id
      end
      it 'is displayed' do
        expect(response).to be_successful
        expect(response).to render_template :show
      end
    end
  end
  describe '#create' do
    describe 'GET' do
      before do
        expect(Distribot::Workflow).to receive(:new)
        get :create
      end
      it 'renders the correct template' do
        expect(response).to render_template :create
      end
    end
    describe 'POST' do
      context 'when successful' do
        before do
          @workflow = Distribot::Workflow.new(id: 'xxx')
          expect(Distribot::Workflow).to receive(:create!){ @workflow }
          post :create, json: {foo: :bar}.to_json
        end
        it 'creates a new workflow and redirects to view the new workflow' do
          expect(flash[:notice]).not_to be_nil
          expect(response).to redirect_to show_workflow_path(workflow_id: @workflow.id)
        end
      end
      context 'when creation fails' do
        context 'because of bad JSON' do
          before do
            post :create, json: 'this is not JSON'
          end
          it 'says it was bad JSON, and lets the user try again' do
            expect(response).to render_template :create
            expect(flash[:error]).to match 'Invalid JSON'
          end
        end
        context 'for some other reason' do
          before do
            expect(Distribot::Workflow).to receive(:create!){ raise "Test Error" }
            post :create, json: {some_json: :that_fails}.to_json
          end
          it 'allows the user to try again' do
            expect(response).to render_template :create
            expect(flash[:error]).to match 'try again'
          end
        end
      end
    end
  end
end
