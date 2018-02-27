Fabricator(:review) do
  stars { (1..5).to_a.sample }
  content { Faker::Lorem.paragraph }
  business { Fabricate(:business) }
  user { Fabricate(:user) }
end