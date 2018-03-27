# RSPEC - CONTROLLERS - users_spec.rb

require "rails_helper"

describe UsersController do
  describe "GET new" do
    it "sets @user if no user is logged in" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
    
    context "user already logged in" do
      before(:each) do
        set_test_user
        get :new
      end
      
      it_behaves_like "danger_message"
      it_behaves_like "root_redirect"
    end
  end
  
  describe "GET show" do
    it "sets @user" do
      set_test_user
      get :show, params: { id: test_user.slug }
      expect(assigns(:user)).to eq(test_user)
    end
  end
  
  describe "POST create" do
    context "valid input" do
      let!(:valid_user_params) { Fabricate.attributes_for(:user) }
      
      before(:each) do
        post :create, params: { user: valid_user_params }
      end
      
      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
      
      it "saves a new user to the database using provided params" do
        expect(User.find_by(email: valid_user_params[:email]).email).to eq(valid_user_params[:email])
      end
      
      it "sets session[:user_id]" do
        expect(session[:user_id]).to eq(User.find_by(email: valid_user_params[:email]).id)
      end
      
      it_behaves_like "success_message"
      it_behaves_like "root_redirect"
    end
    
    context "invalid input" do
      let!(:invalid_user_params) { Fabricate.attributes_for(:user, email: "") }
      
      before(:each) do
        post :create, params: { user: invalid_user_params }
      end
      
      it "does not add a user to the database" do
        expect(User.count).to eq(0)
      end
      
      it_behaves_like "danger_message"
    end
    
    context "user already logged in" do
      before(:each) do
        set_test_user
        post :create, params: { user: Fabricate.attributes_for(:user) }
      end
      
      it "does not change session[:user_id]" do
        expect(session[:user_id]).to eq(test_user.id)
      end
      
      it_behaves_like "danger_message"
      it_behaves_like "root_redirect"
    end
  end
  
  describe "GET edit" do
    before(:each) { set_test_user }
    
    context "authenticated user" do
      context "current user" do
        it "sets @user to the appropriate user" do
          get :edit, params: { id: test_user.slug }
          expect(assigns(:user)).to eq(test_user)
        end
      end
      
      context "other user" do
        before(:each) do
          get :edit, params: { id: Fabricate(:user).slug }
        end
      
        it_behaves_like "danger_message"
        it_behaves_like "root_redirect"
      end
    end
    
    context "unauthenticated user" do
      before(:each) do
        get :edit, params: { id: Fabricate(:user).slug }
      end
    
      it_behaves_like "danger_message"
      it_behaves_like "root_redirect"
    end
  end
  
  describe "PUT update" do
    let!(:valid_user_params) { Fabricate.attributes_for(:user) }
    
    context "authenticated user" do
      before(:each) { set_test_user }
      
      context "current_user" do
        context "valid input" do
          before(:each) do
            put :update, params: { id: test_user.slug, user: valid_user_params }
          end
          
          it "sets @user" do
            expect(assigns(:user)).to eq(test_user)
          end
          
          it "adjusts the user's attributes" do
            expect(test_user.email).to eq(valid_user_params[:email])
          end
          
          it "redirects to user_path" do
            expect(response).to redirect_to(user_path(test_user))
          end
          
          it_behaves_like "success_message"
        end
        
        context "invalid input" do
          let!(:invalid_user_params) { Fabricate.attributes_for(:user, email: "") }
          
          before(:each) do
            put :update, params: { id: test_user.slug, user: invalid_user_params }
          end
          
          it "does not update user attributes" do
            expect(test_user.email).not_to eq(invalid_user_params[:email])
          end
          
          it_behaves_like "danger_message"
        end
      end
      
      context "other user" do
        before(:each) do
          put :update, params: { id: Fabricate(:user).slug, user: valid_user_params }
        end
      
        it_behaves_like "danger_message"
        it_behaves_like "root_redirect"
      end
    end
    
    context "unauthenticated user" do
      before(:each) do
        put :update, params: { id: Fabricate(:user).slug, user: valid_user_params }
      end
    
      it_behaves_like "danger_message"
      it_behaves_like "root_redirect"
    end
  end
end
