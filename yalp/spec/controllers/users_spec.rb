# RSPEC - CONTROLLERS - users_spec.rb

require "rails_helper"

describe UsersController do
  describe "GET new" do
    it "sets @user if no user is logged in" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
    
    it "redirects to root_path if user already logged in"
  end
end