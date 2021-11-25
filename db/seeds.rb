# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Admin.new(
  email: "test@test.com",
  password: "tester123")
admin.save!

admin_customer = Customer.new(
  id: 0,
  nickname: "admin",
  email: "admin@admin",
  password: "adminsan"
  )
admin_customer.save!

total = 0
for i in 1..100 do
  next_rank_exp = (i*Math.log(i)).ceil
  rank = Rank.new(rank: i, experience_point: next_rank_exp+total)
  rank.save!
  total += next_rank_exp
end

rank = Rank.new(rank: 101, experience_point: 999999999)
rank.save!

question = Question.new(
  customer_id: 0,
  title: "First Question",
  sentence: "このサイトの名前は？",
  format: "choose_one",
  explanation: "Artisan: 職人"
  )
question.save!

Answer.create!(
  [
    {
      question_id: question.id,
      content: "Question Artisan",
      is_correct: true
    },
    {
      question_id: question.id,
      content: "Question Artist",
      is_correct: false
    },
    {
      question_id: question.id,
      content: "Question Answer",
      is_correct: false
    },
    {
      question_id: question.id,
      content: "Question Alchemist",
      is_correct: false
    }
  ])