class TransferController < ApplicationController
  before_action :set_headers

  def set_headers
    response.headers['Content-Type'] = 'application/json'
  end

  def send_money
    create_transactions
    from_account.decrement!(:balance, amount.to_f)
    to_account.increment!(:balance, amount.to_f)

    render json: {
      newSrcBalance: from_account.balance.to_f,
      totalDestBalance: to_account.balance.to_f,
      transferedAt: Time.now
    }
  end

  def create_transactions
    Transaction.create({ account_id: from_account.id, amount: -amount }
      .merge(transaction_params))
    Transaction.create({ account_id: to_account.id, amount: amount }
      .merge(transaction_params))
  end

  private

  def transaction_params
    {
      name: "Transfer from Account ID #{from_account.id} to #{to_account.id}"
    }
  end

  def transfer_params
    params.permit(:fromAccountId, :toAccountId, :amount)
  end

  def from_account
    @from_account ||= Account.find(transfer_params[:fromAccountId])
  end

  def to_account
    @to_account ||= Account.find(transfer_params[:toAccountId])
  end

  def amount
    @amount ||= transfer_params[:amount]
  end
end
