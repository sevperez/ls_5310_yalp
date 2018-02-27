# RSPEC - CONTROLLERS - categories_spec.rb

require "rails_helper"

describe CategoriesController do
  describe "GET businesses" do
    let!(:cat) { Fabricate(:category) }
    let!(:bus_1) { Fabricate(:business, category: cat) }
    let!(:bus_2) { Fabricate(:business, category: cat) }
    let!(:bus_3) { Fabricate(:business, category: cat) }
    let!(:rev_1) { Fabricate(:review, business: bus_3, stars: 5) }
    let!(:rev_2) { Fabricate(:review, business: bus_1, stars: 3) }
    
    before(:each) do
      Business.all.each { |b| b.update_average_star_score }
      get :businesses, params: { id: cat.slug }
    end
    
    it "sets @category" do
      expect(assigns(:category)).to eq(cat)
    end
    
    it "sets @businesses to all those with @category" do
      expect(assigns(:businesses).first).to be_instance_of(Business)
      expect(assigns(:businesses).count).to eq(3)
    end
    
    it "sorts businesses by star rating" do
      expect(assigns(:businesses).first).to eq(bus_3)
      expect(assigns(:businesses).last).to eq(bus_2)
    end
  end
  
  describe "GET reviews" do
    let!(:cat) { Fabricate(:category) }
    let!(:bus_1) { Fabricate(:business, category: cat) }
    let!(:bus_2) { Fabricate(:business, category: cat) }
    let!(:bus_3) { Fabricate(:business, category: cat) }
    let!(:rev_1) { Fabricate(:review, business: bus_1) }
    let!(:rev_2) { Fabricate(:review, business: bus_2) }
    let!(:rev_3) { Fabricate(:review, business: bus_3) }
    
    before(:each) do
      get :reviews, params: { id: cat.slug }
    end
    
    it "sets @category" do
      expect(assigns(:category)).to eq(cat)
    end
    
    it "sets @reviews to all those for a business with @category" do
      expect(assigns(:reviews).first).to be_instance_of(Review)
      expect(assigns(:reviews).count).to eq(3)
    end
  end
end