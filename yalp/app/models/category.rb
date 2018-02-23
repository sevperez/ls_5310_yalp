class Category < ActiveRecord::Base
  include Sluggable
  
  validates :name, presence: true
  
  has_many :businesses
  
  set_slug_key :name
end
