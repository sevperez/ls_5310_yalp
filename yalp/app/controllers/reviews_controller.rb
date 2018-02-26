class ReviewsController < ApplicationController
  before_action :require_user, only: [:create]
  
  def create
    business = Business.find_by(slug: params[:id])
    
    @review = Review.new(review_params)
    @review.user = current_user
    @review.business = business
    
    if @review.save
      business.update_average_star_score
      flash[:success] = "Your review has been added!"
      redirect_to business_path(business)
    else
      flash[:danger] = "Unable to save your review."
      redirect_to business_path(business)
    end
  end
  
  private
  
  def review_params
    params.require(:review).permit(:stars, :content)
  end
end