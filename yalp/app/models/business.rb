class Business < ActiveRecord::Base
  include Sluggable
  
  validates :name, presence: { message: "A business name is required." }, uniqueness: { message: "Sorry, that business name is taken." }
  validates :description, presence: { message: "A short description is required." }
  validates :address, presence: { message: "An address is required." }
  validates :city, presence: { message: "A city is required." }
  validates :state, presence: { message: "A state is required." }
  validates :phone_number, presence: { message: "A phone number is required." }
  
  belongs_to :category
  belongs_to :owner, foreign_key: "user_id", class_name: "User"
  
  set_slug_key :name
end
