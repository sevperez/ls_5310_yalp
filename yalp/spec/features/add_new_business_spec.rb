# RSPEC - FEATURES - add_new_business_spec.rb

require "rails_helper"

feature "add new business" do
  given(:user) { Fabricate(:user, email: "test@user.com", password: "password") }
  given!(:food_and_drink) { Fabricate(:category, name: "Food and Drink", id: 2) }
  
  context "authenticated user" do
    background do
      feature_sign_in_user(user.email, user.password)
      click_link "Add Business"
    end
    
    scenario "valid inputs" do
      within(:css, "#new_business") do
        fill_in "Business Name", with: "Test Restaurant"
        select("Food and Drink", from: "Category")
        fill_in "Address", with: "123 My Address"
        select("California", from: "State")
        fill_in "City", with: "Yalptown"
        fill_in "Zip Code", with: "12345"
        fill_in "Phone Number", with: "555-555-5555"
        fill_in "Website", with: "www.testrestaurant.com"
        select("9", from: "Opening Time")
        select("17", from: "Closing Time")
        fill_in "Description", with: "The best restaurant you will ever try."
      end
      click_button "Add"
      
      expect(page).to have_content("Your business has been added to the registry!")
      expect(page).to have_content("Test Restaurant")
    end
    
    scenario "invalid inputs" do
      within(:css, "#new_business") do
        fill_in "Business Name", with: ""
        select("Food and Drink", from: "Category")
        fill_in "Address", with: "123 My Address"
        select("California", from: "State")
        fill_in "City", with: "Yalptown"
        fill_in "Zip Code", with: "12345"
        fill_in "Phone Number", with: "555-555-5555"
        fill_in "Website", with: "www.testrestaurant.com"
        select("9", from: "Opening Time")
        select("17", from: "Closing Time")
        fill_in "Description", with: "The best restaurant you will ever try."
      end
      click_button "Add"
      
      expect(page).to have_content("Hmmm, there seems to have been an error. Please check your input.")
      expect(page).to have_content("A business name is required.")
    end
  end
  
  context "unauthenticated user" do
    scenario "attempts to access businesses/new action" do
      visit new_business_path
      expect(page).to have_content("You must be logged in to perform that action.")
    end
  end
end
