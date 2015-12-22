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
end
