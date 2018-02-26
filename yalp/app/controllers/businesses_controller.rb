class BusinessesController < ApplicationController
  before_action :set_business, only: [:show]
  
  def index
    @businesses = Business.all
  end
  
  def show
  end
  
  private
  
  def set_business
    @business = Business.find_by(slug: params[:id])
  end
end