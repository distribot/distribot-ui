require 'spec_helper'

describe SigninController do
  describe '#signin' do
    before do
      @user = FactoryGirl.create(:user)
      @form = {
        email: @user.email,
        password: @user.password
      }
    end
    context 'when the email' do
      context 'is valid' do
        context 'and the password' do
          context 'is correct' do
            before do
              post :signin, @form
            end
            it 'signs the user in' do
              expect(session[:user_id]).to eq @user.id
            end
            it 'redirects to /' do
              expect(response).to redirect_to :admin_home
            end
          end
          context 'is incorrect' do
            before do
              @form[:password] = 'invalid-password'
              post :signin, @form
            end
            it 'redirects back to signin page' do
              expect(response).to redirect_to :signin
            end
            it 'sets the error message' do
              expect(flash[:error]).not_to be_nil
            end
          end
        end
      end
      context 'is invalid' do
        before do
          @form[:email] = 'invalid@invalid.com'
          post :signin, @form
        end
        it 'redirects back to signin page' do
          expect(response).to redirect_to :signin
        end
        it 'sets the error message' do
          expect(flash[:error]).not_to be_nil
        end
      end
    end
  end

  describe '#signout' do
    context 'when signed in' do
      before do
        @user = FactoryGirl.create(:user)
        controller.sign_in @user
        get :signout
      end
      it 'redirects to signin' do
        expect(response).to redirect_to :signin
      end
      it 'removes session:user_id' do
        expect(session[:user_id]).to be_nil
      end
    end
    context 'when not signed in' do
      before do
        get :signout
      end
      it 'redirects to signin' do
        expect(response).to redirect_to :signin
      end
    end
  end
end
