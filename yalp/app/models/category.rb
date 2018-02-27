class Category < ActiveRecord::Base
  include Sluggable
  
  validates :name, presence: true
  
  has_many :businesses
  
  set_slug_key :name
  
  def number_business_pages
    count = self.businesses.count
    count == 0 ? 1 : (count.to_f / Business::BUSINESSES_PER_PAGE).ceil
  end
  
  def number_review_pages
    count = 0
    
    self.businesses.each do |b|
      count += b.reviews.count
    end
    
    count == 0 ? 1 : (count.to_f / Review::REVIEWS_PER_PAGE).ceil
  end
  
  def self.select_options
    self.order("name ASC").map do |cat|
      [cat.name, cat.id]
    end
  end
end
