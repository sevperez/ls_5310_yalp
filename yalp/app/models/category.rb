class Category < ActiveRecord::Base
  include Sluggable
  
  validates :name, presence: true
  
  has_many :businesses
  
  set_slug_key :name
  
  def number_pages
    count = self.businesses.count
    count == 0 ? 1 : (count.to_f / Business::BUSINESSES_PER_PAGE).ceil
  end
  
  def self.select_options
    self.order("name ASC").map do |cat|
      [cat.name, cat.id]
    end
  end
end
