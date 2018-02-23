Fabricator(:business) do
  name { Faker::Lorem.words(2).join(" ").titleize }
  description { Faker::Lorem.paragraph }
  address { Faker::Address.street_name }
  city { Faker::Address.city }
  state { Faker::Address.state_abbr }
  zip_code { Faker::Address.zip_code }
  phone_number { Faker::PhoneNumber.phone_number }
  website { Faker::Internet.url }
  open_hr { (8..11).to_a.sample.to_s.rjust(2, "0") + ":00" }
  close_hr { (17..22).to_a.sample.to_s + ":00" }
  category { Category.count > 0 ? Category.all.sample : Fabricate(:category) }
  owner { Fabricate(:user) }
end
