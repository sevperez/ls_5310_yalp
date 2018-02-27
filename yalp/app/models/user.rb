class User < ActiveRecord::Base
  include Sluggable
  
  validates :full_name, presence: { message: "Full name is required." }
  validates :email, presence: { message: "A valid email is required." }, uniqueness: { message: "Sorry, that email is unavailable." }
  validates :password, presence: { message: "Password is required." }, length: { minimum: 8, message: "Must be at least 8 characters."}, on: :create
  validates :motto, length: { maximum: 250, message: "Motto must be less than 250 characters." }
  
  has_secure_password validations: false
  
  has_many :businesses
  has_many :reviews
  has_many :reviewed_businesses, through: :reviews, source: :business
  
  set_slug_key :full_name
  
  def review_count
    reviews.count
  end
  
  def has_reviewed?(business)
    reviews.all.pluck(:business_id).include?(business.id)
  end
end
