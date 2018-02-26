# RSPEC - MODELS - business_spec.rb

require "rails_helper"

describe Business do
  context "ActiveRecord" do
    it { should validate_presence_of(:name).with_message("A business name is required.") }
    it { should validate_uniqueness_of(:name).with_message("Sorry, that business name is taken.") }
    it { should validate_presence_of(:description).with_message("A short description is required.") }
    it { should validate_presence_of(:address).with_message("An address is required.") }
    it { should validate_presence_of(:city).with_message("A city is required.") }
    it { should validate_presence_of(:state).with_message("A state is required.") }
    it { should validate_presence_of(:phone_number).with_message("A phone number is required.") }
    it { should belong_to(:owner).with_foreign_key("user_id") }
    it { should belong_to(:category) }
    it { should have_many(:reviews) }
    it { should have_many(:reviewers) }
  end
  
  # slugging
  it_behaves_like "sluggable" do
    let(:item_type_sym) { :business }
    let(:item_attr) { :name }
  end
end
