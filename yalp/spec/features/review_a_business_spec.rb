# RSPEC - FEATURES - review_a_business_spec.rb

require "rails_helper"

feature "review a business" do
  given!(:test_user) { Fabricate(:user, full_name: "Test Q. User", email: "test@user.com", password: "password") }
  given!(:great_restaurant) { Fabricate(:business, name: "Great Restaurant", category: Fabricate(:category, name: "Food and Drink", id: 2)) }
  
  scenario "authenticated user" do
    # sign in
    visit sign_in_path
    
    within("#sign_in_form form") do
      fill_in "Email", :with => "test@user.com"
      fill_in "Password", :with => "password"
    end
    click_button "Submit"
    expect(page).to have_content(test_user.full_name)
    
    # go to businesses pages and click on a business
    click_link "Businesses"
    expect(page).to have_link(great_restaurant.name)
    
    # rate business on show page
    click_link great_restaurant.name
    expect(page).to have_content(great_restaurant.description)
    
    within("#new_review") do
      select("3", from: "review_stars")
      fill_in "Content", with: "I love this place!"
    end
    click_button "Submit"
    expect(page).to have_content("I love this place!")
    
    # check for review on food-and-drink/reviews page
    page.find_link(href: "/categories/food-and-drink/reviews").click
    expect(page).to have_content("I love this place!")
  end
  
  scenario "unauthenticated user" do
    # go to businesses pages and click on a business
    visit root_path
    
    click_link "Businesses"
    expect(page).to have_link(great_restaurant.name)
    
    # business show page should not have a new review form
    click_link great_restaurant.name
    expect(page).not_to have_selector("#new_review")
  end
end