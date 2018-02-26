class CategoriesController < ApplicationController
  def businesses
    @category = Category.find_by(slug: params[:id])
    @businesses = Business.sort_by_stars_then_name(@category.businesses)
  end
end
