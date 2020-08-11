# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

10.times do |_x|
  User.create(name: Faker::Name.name)
end

20.times do |_x|
  Account.create(
    name: Faker::Bank.name,
    type: ['Accounts::SavingsAccount',
           'Accounts::CurrentAccount',
           'Accounts::BasicSavingsAccount'].sample,
    balance: Faker::Number.decimal(l_digits: 2),
    user_id: (1..10).to_a.sample
  )
end
