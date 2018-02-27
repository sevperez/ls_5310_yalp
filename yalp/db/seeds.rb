# SEEDS

# Users
popeye = User.create(full_name: "Popeye Perez", email: "popeye@pops.com", password: "password", timezone: "Pacific Time (US & Canada)", motto: "You either die a good boy, or you live long enough to see yourself become a bad dog.")

olive = User.create(full_name: "Olive Oil", email: "olive@oil.com", password: "password", timezone: "Pacific Time (US & Canada)", motto: "If you can't beat 'em, join 'em.")

20.times do |_|
  Fabricate(:user, password: "password")
end

# Categories
["Activities", "Food and Drink", "Lodging", "Shopping", "Services"].each do |cat_name|
  Category.create(name: cat_name)
end

# Businesses
100.times do |_|
  Fabricate(:business, owner: User.all.sample)
end

# Reviews
User.all.each do |u|
  next if u.email == "popeye@pops.com" || u.email == "olive@oil.com"
  
  Business.all.each do |b|
    if [true, false, false, false].sample
      content = ""
      
      if [true, false].sample
        content = Faker::Lorem.paragraph([1, 2].sample)
      end
      
      Fabricate(:review, user: u, business: b, content: content)
    end
  end
end
