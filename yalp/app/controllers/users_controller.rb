class UsersController < ApplicationController
  before_action :require_no_user, only: [:new, :create]
  before_action :set_user, only: [:show]
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User registration successful!"
      redirect_to root_path
    else
      flash[:danger] = "Hmm, looks like there was an error."
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:full_name, :email, :password, :timezone, :motto)
  end
  
  def set_user
    @user = User.find_by(slug: params[:id])
  end
end
