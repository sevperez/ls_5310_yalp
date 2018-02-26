# RSPEC - MODELS - review_spec.rb

require "rails_helper"

describe Review do
  context "ActiveRecord" do
    it { should validate_presence_of(:stars).with_message("A star rating is required.") }
    it { should validate_inclusion_of(:stars).in_range(1..5).with_message("Star rating must be between 1 and 5.") }
    it { should validate_length_of(:content).is_at_most(2000).with_message("Review content must be less than 2000 characters in length.") }
    it { should belong_to(:business) }
    it { should belong_to(:user) }
  end
end