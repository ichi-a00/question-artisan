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