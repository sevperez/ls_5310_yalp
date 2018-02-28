# RSPEC - FEATURES - user_sign_in_and_out_spec.rb

require "rails_helper"

feature "user sign in" do
  given!(:user) { Fabricate(:user, full_name: "Test Q. User", password: "password", email: "test@user.com") }
  given!(:great_restaurant) { Fabricate(:business, name: "Great Restaurant") }
  
  background do
    # Visits home page and clicks on "sign in" button
    visit root_path
    expect(page).to have_content("Sign In")
    click_link "Sign In"
    expect(page).to have_selector("#sign_in_form")
  end

  scenario "valid credentials" do
    # Fills out sign in form with valid credentials
    within("#sign_in_form form") do
      fill_in "Email", :with => "test@user.com"
      fill_in "Password", :with => "password"
    end
    click_button "Submit"
    
    expect(page).to have_content("Sign in successful!")
    expect(page).to have_content("Test Q. User")
    expect(page).to have_link("Sign Out")
    expect(page).not_to have_link("Sign In")
    
    # Signs out from root page
    click_link "Sign Out"
    
    expect(page).to have_content("You are now signed out.")
    expect(page).to have_link("Sign In")
  end
  
  scenario "invalid credentials" do
    # Fills out sign in form with invalid credentials
    within("#sign_in_form form") do
      fill_in "Email", :with => "test@user.com"
      fill_in "Password", :with => "wrong_password"
    end
    click_button "Submit"
    
    expect(page).to have_content("Unable to sign in with those credentials.")
  end
end
