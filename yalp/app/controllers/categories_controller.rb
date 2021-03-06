class CategoriesController < ApplicationController
  before_action :set_category, only: [:businesses, :reviews]

  def businesses
    page_num = params[:page].to_i
    @num_pages = @category.number_business_pages
    
    @businesses = Business.retrieve_by_stars(page_num, @category)
  end
  
  def reviews
    page_num = params[:page].to_i
    @num_pages = @category.number_review_pages
    
    @reviews = Review.retrieve_by_newest(page_num, @category)
  end
  
  private
  
  def set_category
    @category = Category.find_by(slug: params[:id])
  end
end
