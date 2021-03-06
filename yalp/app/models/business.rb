class Business < ActiveRecord::Base
  include Sluggable
  
  BUSINESSES_PER_PAGE = 10
  
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
  
  def all_text
    "#{self.name} #{self.description} #{self.city} #{self.state} #{self.zip_code} #{self.address} #{self.website} #{self.phone_number}".downcase
  end
  
  def self.number_pages
    count = self.count
    count == 0 ? 1 : (count.to_f / BUSINESSES_PER_PAGE).ceil
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
  
  def self.retrieve_by_stars(page_num, category=nil)
    if category
      return [] if page_num > category.number_business_pages
      businesses = category.businesses
    else
      return [] if page_num > self.number_pages
      businesses = self.all
    end
    
    offset = page_num.nil? || page_num == 0 ? 0 : (page_num - 1) * BUSINESSES_PER_PAGE
    page_businesses = self.sort_by_stars_then_name(businesses)
    page_businesses[offset..offset + BUSINESSES_PER_PAGE - 1]
  end
  
  def self.search(term)
    term = term.blank? ? nil : term.downcase
    
    if term.nil?
      search_results = []
    elsif self.is_state?(term)
      abbr = if term.length == 2
              term.upcase
            else
              states = ApplicationController.helpers.us_states
              states.select { |state| state[0].downcase == term.downcase }[0][1]
            end
                   
      search_results = Business.where(state: abbr)
    else
      search_results = Business.all.select { |b| b.all_text.include?(term) }
    end
  end
  
  def self.is_state?(term)
    states = ApplicationController.helpers.us_states
    
    full_state_names = states.map { |state| state[0].downcase }
    state_abbreviations = states.map { |state| state[1].downcase }

    full_state_names.include?(term) || state_abbreviations.include?(term)
  end
end
