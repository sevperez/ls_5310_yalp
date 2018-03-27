# SEEDS

# Users
test_user = User.create(full_name: "Test User", email: "test@user.com", password: "password", timezone: "Pacific Time (US & Canada)", motto: "Gotta love testing.")

20.times do |_|
  Fabricate(:user, password: "password")
end

# Categories
["Activities", "Food and Drink", "Lodging", "Shopping", "Services"].each do |cat_name|
  Category.create(name: cat_name)
end

# Businesses
50.times do |_|
  b = Fabricate(:business, owner: User.all.sample)
  b.update_average_star_score
end

# Reviews
User.all.each do |u|
  next if u.email == "test@user.com"
  
  Business.all.each do |b|
    if [true, false, false, false].sample
      content = ""
      
      if [true, false].sample
        content = Faker::Lorem.paragraph([1, 2].sample)
      end
      
      Fabricate(:review, user: u, business: b, content: content, created_at: DateTime.now - (1..100).to_a.sample)
    end
  end
end
