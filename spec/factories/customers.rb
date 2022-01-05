FactoryBot.define do
  factory :customer do
    id { 1 }
    nickname { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(max_length: 6) }
  end
end
