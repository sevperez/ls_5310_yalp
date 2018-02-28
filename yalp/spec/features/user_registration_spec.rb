# RSPEC - FEATURES - user_registration_spec.rb

require "rails_helper"

feature "user registration" do
  scenario "register" do
    # Visits home page and clicks on "register" button
    visit root_path
    expect(page).to have_content("Register")
    click_link "Register"
    expect(page).to have_content("User Registration")
    
    # Fills in form with invalid inputs (no email) and gets an error message
    within("#new_user") do
      fill_in "Full Name", :with => "Test Q. User"
      fill_in "Password", :with => "password"
      fill_in "Personal Motto", :with => "I love testing with Capybara!"
    end
    click_button "Register"
    expect(page).to have_content("A valid email is required.")
    
    # Fixes form input, forgetting to re-fill out password
    within("#new_user") do
      fill_in "Email", :with => "test@user.com"
    end
    click_button "Register"
    expect(page).to have_content("Password is required.")
    
    # Fixes form input one last time, and successfully registers
    within("#new_user") do
      fill_in "Password", :with => "super_secret"
    end
    click_button "Register"
    expect(page).to have_content("User registration successful!")
  end
end
