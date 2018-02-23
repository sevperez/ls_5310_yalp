class Category < ActiveRecord::Base
  include Sluggable
  
  validates :name, presence: true
  
  set_slug_key :name
end
