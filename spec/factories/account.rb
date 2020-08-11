require 'faker'

FactoryBot.define do
  factory :account do
    name { Faker::Bank.name }
    type { ['Accounts::SavingsAccount',
            'Account::CurrentAccount',
            'Account::BasicSavingsAccount'].sample }
    balance {  Faker::Number.decimal(l_digits: 2) }
    user
  end
end
