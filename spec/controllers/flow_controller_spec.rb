require 'spec_helper'

describe FlowController do
  describe '#list' do
    context 'when there' do
      context 'are flows' do
        before do
          expect(Distribot::Flow).to receive(:active) do
            flow = double('flow')
            [ flow ]
          end
          get :list
        end
        it 'lists them' do
          expect(response).to render_template :list
        end
      end
      context 'are no flows' do
        before do
          expect(Distribot::Flow).to receive(:active){ [] }
          get :list
        end
        it 'shows the empty state' do
          expect(response).to render_template :empty_list
        end
      end
    end
  end
  describe '#show' do
    context 'when the flow exists' do
      before do
        @flow = Distribot::Flow.new(id: 'xxx')
        expect(Distribot::Flow).to receive(:find).with('xxx'){ @flow }
        get :show, flow_id: @flow.id
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
        expect(Distribot::Flow).to receive(:new)
        get :create
      end
      it 'renders the correct template' do
        expect(response).to render_template :create
      end
    end
    describe 'POST' do
      context 'when successful' do
        before do
          @flow = Distribot::Flow.new(id: 'xxx')
          expect(Distribot::Flow).to receive(:create!){ @flow }
          post :create, json: {foo: :bar}.to_json
        end
        it 'creates a new flow and redirects to view the new flow' do
          expect(flash[:notice]).not_to be_nil
          expect(response).to redirect_to show_flow_path(flow_id: @flow.id)
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
            expect(Distribot::Flow).to receive(:create!){ raise "Test Error" }
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
