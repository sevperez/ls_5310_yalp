# RSPEC - FEATURES - user_registration_spec.rb

require "rails_helper"

feature "user registration" do
  scenario "register" do
    visit root_path
    click_link "Register"
    expect(page).to have_content("User Registration")
    
    within("#new_user") do
      fill_in "Full Name", with: "Test Q. User"
      fill_in "Password", with: "password"
      fill_in "Personal Motto", with: "I love testing with Capybara!"
    end
    click_button "Register"
    expect(page).to have_content("A valid email is required.")
    
    within("#new_user") do
      fill_in "Email", with: "test@user.com"
    end
    click_button "Register"
    expect(page).to have_content("Password is required.")
    
    within("#new_user") do
      fill_in "Password", with: "super_secret"
    end
    click_button "Register"
    expect(page).to have_content("User registration successful!")
  end
end
