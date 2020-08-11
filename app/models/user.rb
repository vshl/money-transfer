class User < ApplicationRecord
  has_many :accounts

  def total_balance
    accounts.sum(&:balance)
  end
end
