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
  
  def is_state?(term)
    state_arr = [
                  ["Alabama", "AL"],
                  ["Alaska", "AK"],
                  ["Arizona", "AZ"],
                  ["Arkansas", "AR"],
                  ["California", "CA"],
                  ["Colorado", "CO"],
                  ["Connecticut", "CT"],
                  ["Delaware", "DE"],
                  ["District of Columbia", "DC"],
                  ["Florida", "FL"],
                  ["Georgia", "GA"],
                  ["Hawaii", "HI"],
                  ["Idaho", "ID"],
                  ["Illinois", "IL"],
                  ["Indiana", "IN"],
                  ["Iowa", "IA"],
                  ["Kansas", "KS"],
                  ["Kentucky", "KY"],
                  ["Louisiana", "LA"],
                  ["Maine", "ME"],
                  ["Maryland", "MD"],
                  ["Massachusetts", "MA"],
                  ["Michigan", "MI"],
                  ["Minnesota", "MN"],
                  ["Mississippi", "MS"],
                  ["Missouri", "MO"],
                  ["Montana", "MT"],
                  ["Nebraska", "NE"],
                  ["Nevada", "NV"],
                  ["New Hampshire", "NH"],
                  ["New Jersey", "NJ"],
                  ["New Mexico", "NM"],
                  ["New York", "NY"],
                  ["North Carolina", "NC"],
                  ["North Dakota", "ND"],
                  ["Ohio", "OH"],
                  ["Oklahoma", "OK"],
                  ["Oregon", "OR"],
                  ["Pennsylvania", "PA"],
                  ["Puerto Rico", "PR"],
                  ["Rhode Island", "RI"],
                  ["South Carolina", "SC"],
                  ["South Dakota", "SD"],
                  ["Tennessee", "TN"],
                  ["Texas", "TX"],
                  ["Utah", "UT"],
                  ["Vermont", "VT"],
                  ["Virginia", "VA"],
                  ["Washington", "WA"],
                  ["West Virginia", "WV"],
                  ["Wisconsin", "WI"],
                  ["Wyoming", "WY"]
                ]
    
    full_state_names = state_arr.map { |subarr| subarr[0].downcase }
    state_abbreviations = state_arr.map { |subarr| subarr[1].downcase }

    full_state_names.include?(term) || state_abbreviations.include?(term)
  end
end
