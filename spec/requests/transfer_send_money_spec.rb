require 'rails_helper'

RSpec.describe TransferController, type: :request do
  describe 'transfer#send_money' do
    context 'with valid parameters' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }
      let(:fromAccount) { create(:account, user: user) }
      let(:toAccount) { create(:account, user: another_user) }

      let(:valid_params) do {
        fromAccountId: fromAccount.id,
        toAccountId: toAccount.id,
        amount: 50.00
      }
      end

      before do
        headers = { 'ACCEPT' => 'application/json'}
        post '/transfer', params: valid_params
      end

      it 'performs the http request' do
        expect(response).to be_successful
        expect(response.content_type).to eql 'application/json'
        expect(response.body).not_to be_empty
      end

      it 'destination account receives the transfer amount' do
        skip
        expect().to change { toAccount.balance }.by(50.00)
      end

      it 'source account gets the transfer amount deducted' do
        skip
        expect(fromAccount.balance).to change { fromAccount.balance }.by(-50.00)
      end
    end
  end
end
