Fabricator(:user) do
  full_name { Faker::Name.name }
  email { Faker::Internet.safe_email }
  password { Faker::Internet.password }
  timezone { ActiveSupport::TimeZone.us_zones.sample.name }
  motto { Faker::Lorem.sentence }
end
