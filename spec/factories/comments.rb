FactoryBot.define do
  factory :comment do
    question_id { 1 }
    customer_id { 1 }
    body { "MyText" }
  end
end
