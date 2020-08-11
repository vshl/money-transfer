require 'rails_helper'

RSpec.describe TransferController, type: :request do
  describe 'transfer#send_money' do
    context 'with valid parameters' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      let(:fromAccount) { create(:account, user: user, balance: 100.00) }
      let(:toAccount) { create(:account, user: another_user, balance: 75.00) }

      let(:valid_params) do
        {
          fromAccountId: fromAccount.id,
          toAccountId: toAccount.id,
          amount: 50.00
        }
      end

      before do
        headers = { 'ACCEPT' => 'application/json' }
        post '/transfer', params: valid_params
      end

      it 'performs the http request' do
        expect(response).to be_successful
        expect(response.content_type).to eql 'application/json'
        expect(response.body).not_to be_empty
      end

      it 'source account gets the transfer amount deducted' do
        expect(JSON.parse(response.body)['newSrcBalance']).to eq 50.00
      end

      it 'destination account receives the transfer amount' do
        expect(JSON.parse(response.body)['totalDestBalance']).to eq 125.00
      end
    end

    context 'when insufficient account balance' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      let(:fromAccount) { create(:account, user: user, balance: 30.00) }
      let(:toAccount) { create(:account, user: another_user, balance: 75.00) }

      let(:invalid_params) do
        {
          fromAccountId: fromAccount.id,
          toAccountId: toAccount.id,
          amount: 50.00
        }
      end

      before do
        headers = { 'ACCEPT' => 'application/json' }
        post '/transfer', params: invalid_params
      end

      it 'transfer fails if source account balance is insufficient' do
        expect(JSON.parse(response.body)['errorCode']).to eq(-1)
      end
    end

    context 'when BasicSaving account balance exceeds limit' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      let(:fromAccount) { create(:account, user: user, balance: 1_300.00) }
      let(:toAccount) do
        create(
          :account, user: another_user, balance: 49_980.00,
                    type: 'Accounts::BasicSavingsAccount'
        )
      end

      let(:invalid_params) do
        {
          fromAccountId: fromAccount.id,
          toAccountId: toAccount.id,
          amount: 500.00
        }
      end

      before do
        headers = { 'ACCEPT' => 'application/json' }
        post '/transfer', params: invalid_params
      end

      it 'transfer fails if source account balance is insufficient' do
        expect(JSON.parse(response.body)['errorCode']).to eq(-2)
      end
    end
  end
end
