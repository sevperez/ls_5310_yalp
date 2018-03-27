# RSPEC - FEATURES - user_sign_in_and_out_spec.rb

require "rails_helper"

feature "user sign in" do
  given(:user) { Fabricate(:user, full_name: "Test Q. User", password: "password", email: "test@user.com") }

  scenario "valid credentials" do
    feature_sign_in_user(user.email, user.password)
    
    expect(page).to have_content("Sign in successful!")
    expect(page).to have_content("Test Q. User")
    expect(page).to have_link("Sign Out")
    expect(page).not_to have_link("Sign In")
    
    click_link "Sign Out"
    
    expect(page).to have_content("You are now signed out.")
    expect(page).to have_link("Sign In")
  end
  
  scenario "invalid credentials" do
    feature_sign_in_user(user.email, "wrongpassword")
    
    expect(page).to have_content("Unable to sign in with those credentials.")
  end
end

