class CategoriesController < ApplicationController
  def businesses
    @category = Category.find_by(slug: params[:id])
    @businesses = @category.businesses
  end
end
