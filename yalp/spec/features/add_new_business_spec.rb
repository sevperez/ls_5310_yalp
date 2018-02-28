# RSPEC - FEATURES - add_new_business_spec.rb

require "rails_helper"

feature "add new business" do
  given!(:user) { Fabricate(:user, email: "test@user.com", password: "password") }
  given!(:food_and_drink) { Fabricate(:category, name: "Food and Drink", id: 2) }
  
  background do
    # sign in
    visit sign_in_path
    
    within("#sign_in_form form") do
      fill_in "Email", :with => "test@user.com"
      fill_in "Password", :with => "password"
    end
    click_button "Submit"
    expect(page).to have_link("Add Business")
    
    click_link "Add Business"
    expect(page).to have_selector("#new_business")
  end
  
  scenario "valid inputs" do
    within(:css, "#new_business") do
      fill_in "Business Name", with: "Great Restaurant"
      select("Food and Drink", from: "Category")
      fill_in "Address", :with => "123 My Address"
      select("California", from: "State")
      fill_in "City", :with => "Yalptown"
      fill_in "Zip Code", :with => "12345"
      fill_in "Phone Number", :with => "555-555-5555"
      fill_in "Website", :with => "www.greatrestaurant.com"
      select("9", from: "Opening Time")
      select("17", from: "Closing Time")
      fill_in "Description", :with => "The best restaurant you will ever try."
    end
    click_button "Add"
    
    expect(page).to have_content("Your business has been added to the registry!")
    expect(page).to have_content("Great Restaurant")
  end
  
  scenario "invalid inputs" do
    within(:css, "#new_business") do
      fill_in "Business Name", with: ""
      select("Food and Drink", from: "Category")
      fill_in "Address", :with => "123 My Address"
      select("California", from: "State")
      fill_in "City", :with => "Yalptown"
      fill_in "Zip Code", :with => "12345"
      fill_in "Phone Number", :with => "555-555-5555"
      fill_in "Website", :with => "www.greatrestaurant.com"
      select("9", from: "Opening Time")
      select("17", from: "Closing Time")
      fill_in "Description", :with => "The best restaurant you will ever try."
    end
    click_button "Add"
    
    expect(page).to have_content("Hmmm, there seems to have been an error. Please check your input.")
    expect(page).to have_content("A business name is required.")
  end
end