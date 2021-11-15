FactoryBot.define do
  factory :answer do
    question_id { 1 }
    content { "MyString" }
    is_correct { false }
    order { "MyString" }
  end
end
