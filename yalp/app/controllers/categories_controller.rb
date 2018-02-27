class CategoriesController < ApplicationController
  before_action :set_category, only: [:businesses, :reviews]

  def businesses
    @businesses = Business.sort_by_stars_then_name(@category.businesses)
  end
  
  def reviews
    category_reviews = []
    
    @category.businesses.each do |business|
      business.reviews.each do |review|
        category_reviews << review
      end
    end
    
    @reviews = Review.sort_by_newest(category_reviews)
  end
  
  private
  
  def set_category
    @category = Category.find_by(slug: params[:id])
  end
end
