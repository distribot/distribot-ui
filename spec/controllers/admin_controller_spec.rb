require 'spec_helper'

describe AdminController do
  describe '#home' do
    context 'when signed in' do
      before do
        @user = FactoryGirl.create(:user)
        controller.sign_in @user
        get :home
      end
      it 'renders the correct template' do
        expect(response).to render_template :home
      end
    end
    context 'when not signed in' do
      before do
        get :home
      end
      it 'redirects to the signin page' do
        expect(response).to redirect_to :signin
      end
      it 'sets the error message' do
        expect(flash[:error]).not_to be_nil
      end
    end
  end
end
