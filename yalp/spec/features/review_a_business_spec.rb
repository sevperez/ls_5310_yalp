# RSPEC - FEATURES - review_a_business_spec.rb

require "rails_helper"

feature "review a business" do
  given(:user) { Fabricate(:user, full_name: "Test Q. User", email: "test@user.com", password: "password") }
  given!(:restaurant) { Fabricate(:business, name: "Test Restaurant", category: Fabricate(:category, name: "Food and Drink", id: 2)) }
  
  scenario "authenticated user" do
    feature_sign_in_user(user.email, user.password)
    
    click_link "Businesses"
    expect(page).to have_link(restaurant.name)
    
    click_link restaurant.name
    expect(page).to have_content(restaurant.description)
    
    within("#new_review") do
      select("3", from: "review_stars")
      fill_in "Content", with: "I love this place!"
    end
    click_button "Submit"
    expect(page).to have_content("I love this place!")
    
    page.find_link(href: "/categories/food-and-drink/reviews").click
    expect(page).to have_content("I love this place!")
  end
  
  scenario "unauthenticated user" do
    visit root_path
    
    click_link "Businesses"
    expect(page).to have_link(restaurant.name)
    
    click_link restaurant.name
    expect(page).not_to have_selector("#new_review")
  end
end