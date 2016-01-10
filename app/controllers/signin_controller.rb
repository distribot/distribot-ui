
class SigninController < ApplicationController
  def signin
  end

  def submit_signin
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to :admin_home
    else
      flash[:error] = 'Login failed. Please try again.'
      redirect_to :signin
    end
  end

  def signout
    session.delete :user_id
    redirect_to :signin
  end

end
