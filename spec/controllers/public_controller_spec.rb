require 'spec_helper'

describe PublicController do
  describe '#home' do
    before do
      get :home
    end
    it 'renders the correct template' do
      expect(response).to render_template :home
    end
  end
end
