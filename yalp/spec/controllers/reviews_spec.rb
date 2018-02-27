# RSPEC - CONTROLLERS - reviews_spec.rb

require "rails_helper"

describe ReviewsController do
  describe "GET index" do
    let!(:bus) { Fabricate(:business) }
    let!(:rev_1) { Fabricate(:review, business: bus) }
    let!(:rev_2) { Fabricate(:review, business: bus) }
    let!(:rev_3) { Fabricate(:review, business: bus) }
    
    before(:each) { get :index }
    
    it "sets @reviews to all reviews" do
      expect(assigns(:reviews).first).to be_instance_of(Review)
      expect(assigns(:reviews).count).to eq(3)
    end
  end
  
  describe "POST create" do
    let!(:bus) { Fabricate(:business) }
    let!(:valid_input) { { stars: "3", content: Faker::Lorem.paragraph } }
    
    context "authenticated user" do
      before(:each) do
        set_test_user
      end
      
      context "valid input and user has not yet reviewed this business" do
        before(:each) { post :create, params: { id: bus.slug, review: valid_input } }
        
        it "sets @review to the provided params" do
          expect(assigns(:review).content).to eq(valid_input[:content])
        end
        
        it "saves a new review to the database" do
          expect(Review.count).to eq(1)
        end
        
        it "associates a new review with the provided business" do
          expect(bus.reviews.first.content).to eq(valid_input[:content])
        end
        
        it "updates the business' average star score" do
          expect(bus.reload.average_star_score).to eq(3)
        end
        
        it "associates a new review with the current user" do
          expect(test_user.reviews.first.content).to eq(valid_input[:content])
        end
        
        it "redirects to business_path" do
          expect(response).to redirect_to(business_path(bus))
        end
        
        it_behaves_like "success_message"
      end
      
      context "invalid input" do
        let!(:invalid_input) { { stars: "", content: "" } }
        before(:each) { post :create, params: { id: bus.slug, review: invalid_input } }
        
        it "does not save a new review to the database" do
          expect(Review.count).to eq(0)
        end
        
        it_behaves_like "danger_message"
      end
      
      context "user has already reviewed this business" do
        before(:each) do
          Fabricate(:review, user: test_user, business: bus)
          post :create, params: { id: bus.slug, review: valid_input }
        end
        
        it "does not save a new review to the database" do
          expect(Review.count).to eq(1)
        end
        
        it_behaves_like "danger_message"
      end
    end
    
    context "unauthenticated user" do
      before(:each) do
        post :create, params: { id: bus.slug, review: valid_input }
      end
      
      it_behaves_like "danger_message"
      it_behaves_like "root_redirect"
    end
  end
end