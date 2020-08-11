require 'rails_helper'

RSpec.describe 'transfer#create', type: :request do
  describe 'POST /transfer' do
    context 'with valid parameters' do
      let(:user) { build(:user) }
      let(:another_user) { build(:user) }
      let(:fromAccount) { build(:account, user: user) }
      let(:toAccount) { build(:account, user: another_user) }

      let(:valid_params) do {
        fromAccountId: fromAccount.id,
        toAccountId: toAccount.id,
        amount: 50.00
      }
      end

      it 'two transactions to be created' do
        expect { post '/transfer', params: valid_params }
          .to change(Transaction, :count).by(+2)
      end

      it 'destination account receives the transfer amount' do
        post '/transfer', params: valid_params
        expect(response.content_type).to eq('application/json')
        expect(toAccount.balance).to change { toAccount.balance }.by(50.00)
      end

      it 'source account gets the transfer amount deducted' do
        post '/transfer', params: valid_params
        expect(fromAccount.balance).to change { fromAccount.balance }.by(-50.00)
      end
    end
  end
end
