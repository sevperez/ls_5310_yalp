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
  
  describe "GET new" do
    context "authenticated user" do
      it "sets @business" do
        set_test_user
        get :new
        expect(assigns(:business)).to be_instance_of(Business)
        expect(assigns(:business).new_record?).to be true
      end
    end
    
    context "unauthenticated user" do
      before(:each) { get :new }
      it_behaves_like "danger_message"
      it_behaves_like "root_redirect"
    end
  end
  
  describe "POST create" do
    let!(:valid_inputs) { Fabricate.attributes_for(:business, owner: nil) }
    
    context "authenticated user" do
      before(:each) do
        set_test_user
      end
      
      context "valid input" do
        before(:each) do
          post :create, params: { business: valid_inputs }
        end
        
        it "sets @business to the provided params" do
          expect(assigns(:business).name).to eq(valid_inputs[:name])
        end
        
        it "saves a new business to the database" do
          expect(Business.count).to eq(1)
          expect(Business.first.name).to eq(valid_inputs[:name])
        end
        
        it "associates current_user as the owner of the new business" do
          expect(Business.first.owner).to eq(test_user)
        end
        
        it "redirects to business_path" do
          expect(response).to redirect_to(business_path(Business.first))
        end
        
        it_behaves_like "success_message"
      end
      
      context "invalid input" do
        let!(:invalid_inputs) { Fabricate.attributes_for(:business, owner: nil, address: "", phone_number: "") }
        
        before(:each) do
          post :create, params: { business: invalid_inputs }
        end
        
        it "does not save a new business to the database" do
          expect(Business.count).to eq(0)
        end
        
        it_behaves_like "danger_message"
      end
    end
    
    context "unauthenticated user" do
      before(:each) do
        post :create, params: { business: valid_inputs }
      end
      
      it_behaves_like "danger_message"
      it_behaves_like "root_redirect"
    end
  end
end