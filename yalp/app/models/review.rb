class Review < ActiveRecord::Base
  REVIEWS_PER_PAGE = 10
  
  validates :stars, presence: { message: "A star rating is required." }, inclusion: { in: 1..5, message: "Star rating must be between 1 and 5." }
  validates :content, length: { maximum: 2000, message: "Review content must be less than 2000 characters in length." }
  validates_uniqueness_of :user_id, scope: :business_id, message: "You may only review a business once."
  
  belongs_to(:user)
  belongs_to(:business)
  
  def self.number_pages
    count = self.count
    count == 0 ? 1 : (count.to_f / REVIEWS_PER_PAGE).ceil
  end
  
  def self.sort_by_newest(reviews)
    reviews.sort do |a, b|
      b.created_at <=> a.created_at
    end
  end
  
  def self.retrieve_by_newest(page_num, category=nil)
    if category
      return [] if page_num > category.number_review_pages
      
      reviews = []
      
      category.businesses.each do |business|
        business.reviews.each do |review|
          reviews << review
        end
      end
    else
      return [] if page_num > Review.number_pages
      reviews = Review.all
    end
    
    offset = page_num.nil? || page_num == 0 ? 0 : (page_num - 1) * REVIEWS_PER_PAGE
    page_reviews = self.sort_by_newest(reviews)
    page_reviews[offset..offset + REVIEWS_PER_PAGE - 1]
  end
end
