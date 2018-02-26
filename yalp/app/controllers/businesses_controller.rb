class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :set_business, only: [:show]
  
  def index
    @businesses = Business.sort_by_stars_then_name(Business.all)
  end
  
  def show
    @review = Review.new
  end
  
  def new
    @business = Business.new
  end
  
  def create
    @business = Business.new(business_params)
    @business.owner = current_user
    
    if @business.save
      flash[:success] = "Your business has been added to the registry!"
      redirect_to business_path(@business)
    else
      flash[:danger] = "Hmmm, there seems to have been an error. Please check your input."
      render :new
    end
  end
  
  private
  
  def set_business
    @business = Business.find_by(slug: params[:id])
  end
  
  def business_params
    params.require(:business).permit(:name, :description, :address, :city, :state, :zip_code, :phone_number, :website, :open_hr, :close_hr, :category_id)
  end
end