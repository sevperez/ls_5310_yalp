class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :set_business, only: [:show]
  
  def index
    page_num = params[:page].to_i
    @num_pages = Business.number_pages
    @businesses = Business.retrieve_by_stars(page_num)
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
      flash.now[:danger] = "Hmmm, there seems to have been an error. Please check your input."
      render :new
    end
  end
  
  def search
    search_results = Business.search(params[:term])
    sorted_results = Business.sort_by_stars_then_name(search_results)
    
    page_num = if params[:page].blank? || params[:page].to_i == 0
                 1
               else
                 params[:page].to_i
               end
    
    @num_pages = if search_results.count == 0
                   1
                 else
                   (search_results.count.to_f / Business::BUSINESSES_PER_PAGE).ceil
                 end

    offset = (page_num - 1) * Business::BUSINESSES_PER_PAGE
    @results = sorted_results.slice(offset, Business::BUSINESSES_PER_PAGE)
  end
  
  private
  
  def set_business
    @business = Business.find_by(slug: params[:id])
  end
  
  def business_params
    params.require(:business).permit(:name, :description, :address, :city, :state, :zip_code, :phone_number, :website, :open_hr, :close_hr, :category_id)
  end
end