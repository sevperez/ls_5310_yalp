class Category < ActiveRecord::Base
  include Sluggable
  
  validates :name, presence: true
  
  has_many :businesses
  
  set_slug_key :name
  
  def self.select_options
    self.order("name ASC").map do |cat|
      [cat.name, cat.id]
    end
  end
end
