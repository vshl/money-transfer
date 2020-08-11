class TransferController < ApplicationController
  def create; end

  def transfer_params
    params.permit(:fromAccountId, :toAccountId, :amount)
  end
end
