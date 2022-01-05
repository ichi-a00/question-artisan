FactoryBot.define do
  factory :question do
    id { 1 }
    customer_id { 1 }
    title { "MyString" }
    sentence { "MyText" }
    format { 1 }
    explanation { "MyText" }
    question_image_id { "" }
    answer_image_id { "" }
    answered_time { 1 }
    correct_answered_time { 0 }
  end
end
