class SessionsController < ApplicationController
  before_action :require_no_user, only: [:new, :create]

  def new
  end
  
  def create
    user = User.find_by(email: sign_in_params[:email])
    
    if user && user.authenticate(sign_in_params[:password])
      session[:user_id] = user.id
      flash[:success] = "Sign in successful!"
      redirect_to root_path
    else
      flash.now[:danger] = "Unable to sign in with those credentials."
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You are now signed out."
    redirect_to root_path
  end
  
  private
  
  def sign_in_params
    params.permit(:email, :password)
  end
end
