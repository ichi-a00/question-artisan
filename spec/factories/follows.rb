FactoryBot.define do
  factory :follow do
    following_id { 1 }
    followed_id { 1 }
  end
end
