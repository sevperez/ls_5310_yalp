# RSPEC - CONTROLLERS - businesses_spec.rb

require "rails_helper"

describe BusinessesController do
  describe "GET index" do
    let!(:kibble_nook) { Fabricate(:business, name: "Kibble Nook") }
    let!(:bobs_burgers) { Fabricate(:business, name: "Bob's Burgers") }
    let!(:construction_site) { Fabricate(:business, name: "Construction Site") }
    
    it "sets @businesses" do
      get :index
      expect(assigns(:businesses).first).to be_instance_of(Business)
    end
    
    it "sorts businesses by star rating"
  end
  
  describe "GET show" do
    let!(:business) { Fabricate(:business) }
    
    it "sets @business" do
      get :show, params: { id: business.slug }
      expect(assigns(:business)).to eq(business)
    end
  end
end