class Review < ActiveRecord::Base
  validates :stars, presence: { message: "A star rating is required." }, inclusion: { in: 1..5, message: "Star rating must be between 1 and 5." }
  validates :content, length: { maximum: 2000, message: "Review content must be less than 2000 characters in length." }
  validates_uniqueness_of :user_id, scope: :business_id, message: "You may only review a business once."
  
  belongs_to(:user)
  belongs_to(:business)
end
