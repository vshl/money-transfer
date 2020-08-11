class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def savings?
    type == 'Accounts::SavingsAccount'
  end

  def current?
    type == 'Accounts::CurrentAccount'
  end

  def basic_savings?
    type == 'Accounts::BasicSavingsAccount'
  end
end
