class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action."
      redirect_to root_path
    end
  end
  
  def require_no_user
    if logged_in?
      flash[:danger] = "Cannot perform that action while you are logged in."
      redirect_to root_path
    end
  end
  
  def require_current_user
    unless current_user && current_user.slug == params[:id]
      flash[:danger] = "You are not authorized for that action."
      redirect_to root_path
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
end
