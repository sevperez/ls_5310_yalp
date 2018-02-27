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
  has_many :reviews
  has_many :reviewers, through: :reviews, source: :user
  
  set_slug_key :name
  
  def review_count
    reviews.count
  end
  
  def calculate_average_star_score
    scores = reviews.pluck(:stars)
    num_scores = scores.length
    num_scores == 0 ? nil : (scores.reduce(:+) / num_scores.to_f).round(1)
  end
  
  def update_average_star_score
    self.average_star_score = calculate_average_star_score
    self.save
  end
  
  def self.sort_by_stars_then_name(businesses)
    businesses.sort do |a, b|
      if a.average_star_score == b.average_star_score
        a.name <=> b.name
      elsif a.average_star_score.blank?
        1
      elsif b.average_star_score.blank?
        -1
      else
        b.average_star_score <=> a.average_star_score
      end
    end
  end
end
