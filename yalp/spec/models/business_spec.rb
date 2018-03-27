# RSPEC - MODELS - business_spec.rb

require "rails_helper"

describe Business do
  it { is_expected.to validate_presence_of(:name).with_message("A business name is required.") }
  it { is_expected.to validate_uniqueness_of(:name).with_message("Sorry, that business name is taken.") }
  it { is_expected.to validate_presence_of(:description).with_message("A short description is required.") }
  it { is_expected.to validate_presence_of(:address).with_message("An address is required.") }
  it { is_expected.to validate_presence_of(:city).with_message("A city is required.") }
  it { is_expected.to validate_presence_of(:state).with_message("A state is required.") }
  it { is_expected.to validate_presence_of(:phone_number).with_message("A phone number is required.") }
  it { is_expected.to belong_to(:owner).with_foreign_key("user_id") }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:reviews) }
  it { is_expected.to have_many(:reviewers) }
  
  it_behaves_like "sluggable" do
    let(:item_type_sym) { :business }
    let(:item_attr) { :name }
  end
  
  describe "#calculate_average_star_score" do
    let!(:bus) { Fabricate(:business) }
    
    it "returns nil when no reviews exist" do
      expect(bus.calculate_average_star_score).to be_nil
    end
    
    it "when scores exist, returns the average, to one decimal place" do
      Fabricate(:review, stars: "2", business: bus)
      Fabricate(:review, stars: "4", business: bus)
      Fabricate(:review, stars: "5", business: bus)
      
      expect(bus.calculate_average_star_score).to eq(3.7)
    end
  end
  
  describe "#update_average_star_score" do
    let!(:bus) { Fabricate(:business) }
    
    it "updates the average_star_score column when first review is added" do
      Fabricate(:review, stars: "2", business: bus)

      bus.update_average_star_score
      expect(bus.average_star_score).to eq(2)
    end
    
    it "updates the average_star_score column when additional reviews are added" do
      Fabricate(:review, stars: "2", business: bus)
      Fabricate(:review, stars: "4", business: bus)
      Fabricate(:review, stars: "5", business: bus)

      bus.update_average_star_score
      expect(bus.average_star_score).to eq(3.7)
    end
  end
  
  describe "#search" do
    let!(:bus) { Fabricate(:business, name: "Fry's Electronics", description: "A pretty ok electronics store.", address: "340 Portage Ave", city: "Palo Alto", state: "CA", zip_code: "94306", phone_number: "650-496-6000", website: "www.frys.com") }
    
    it "returns an empty array if no results" do
      expect(Business.search("San Francisco").count).to eq(0)
    end
    
    it "returns results based on matching city field" do
      expect(Business.search("Palo Alto").first).to eq(bus)
    end
    
    it "returns results based on matching description" do
      expect(Business.search("electronics store").first).to eq(bus)
    end
    
    it "returns results based on matching state field" do
      expect(Business.search("CA").first).to eq(bus)
    end
    
    it "returns results based on matching name field" do
      expect(Business.search("Fry's").first).to eq(bus)
    end
    
    it "returns results based on matching zip code" do
      expect(Business.search("94306").first).to eq(bus)
    end
  end
end
