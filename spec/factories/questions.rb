FactoryBot.define do
  factory :question do
    customer_id { 1 }
    title { "MyString" }
    sentence { "MyText" }
    format { 1 }
    explanation { "MyText" }
    question_image_id { "MyString" }
    answer_image_id { "MyString" }
    answered_time { 1 }
    correct_answered_time { "MyString" }
  end
end
