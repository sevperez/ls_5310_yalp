# RSPEC - CONTROLLERS - sessions_spec.rb

require "rails_helper"

describe SessionsController do
  describe "GET new" do
    context "user is already logged in" do
      before(:each) do
        set_test_user
        get :new
      end
      
      it_behaves_like "root_redirect"
      it_behaves_like "danger_message"
    end
  end
  
  describe "POST create" do
    context "user is not logged in" do
      let!(:existing_user) { Fabricate(:user) }
      
      context "valid credentials" do
        before(:each) do
          post :create, params: { email: existing_user.email, password: existing_user.password }
        end
        
        it "sets session[:user_id]" do
          expect(session[:user_id]).to eq(existing_user.id)
        end
        
        it_behaves_like "success_message"
        it_behaves_like "root_redirect"
      end
      
      context "invalid credentials" do
        before(:each) do
          post :create, params: { email: existing_user.email, password: "wrong_password" }
        end
        
        it "does not set session[:user_id]" do
          expect(session[:user_id]).to be_nil
        end
        
        it_behaves_like "danger_message"
      end
    end
    
    context "user is already logged in" do
      before(:each) do
        set_test_user
        post :create, params: { email: test_user.email, password: test_user.password }
      end
      
      it_behaves_like "root_redirect"
      it_behaves_like "danger_message"
    end
  end
  
  describe "GET destroy" do
    before(:each) do
      set_test_user
      get :destroy
    end
    
    it "sets session[:user_id] to nil" do
      expect(session[:user_id]).to be_nil
    end
    
    it_behaves_like "success_message"
    it_behaves_like "root_redirect"
  end
end
