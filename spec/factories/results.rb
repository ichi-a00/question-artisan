FactoryBot.define do
  factory :result do
    customer_id { 1 }
    question_id { 1 }
    trial_count { 1 }
    is_cleared { false }
  end
end
