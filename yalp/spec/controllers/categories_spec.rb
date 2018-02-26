# RSPEC - CONTROLLERS - categories_spec.rb

require "rails_helper"

describe CategoriesController do
  describe "GET businesses" do
    let!(:cat) { Fabricate(:category) }
    let!(:bus_1) { Fabricate(:business, category: cat) }
    let!(:bus_2) { Fabricate(:business, category: cat) }
    let!(:bus_3) { Fabricate(:business, category: cat) }
    
    before(:each) do
      get :businesses, params: { id: cat.slug }
    end
    
    it "sets @category" do
      expect(assigns(:category)).to eq(cat)
    end
    
    it "sets @businesses to all those with @category" do
      expect(assigns(:businesses).first).to be_instance_of(Business)
      expect(assigns(:businesses).count).to eq(3)
    end
    
    it "sorts businesses by star rating"
  end
end