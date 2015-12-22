require 'spec_helper'

describe WorkerController do
  describe '#list' do
    before do
      get :list
    end
    it 'renders the correct template' do
      expect(response).to render_template :list
    end
  end
end
