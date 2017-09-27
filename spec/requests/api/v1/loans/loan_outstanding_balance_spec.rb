require 'rails_helper'

RSpec.describe 'Show the outstanding balance', type: :request do
  context 'for a single loan' do
    it 'displays the balance' do
      loan = create(:loan)
      payment_1 = 100.00
      payment_2 = 200.00

      post "/api/v1/loans/#{loan.id}/payments", { amount: payment_1 }
      post "/api/v1/loans/#{loan.id}/payments", { amount: payment_2 }

      outstanding_balance = loan.funded_amount - payment_1 - payment_2

      get "/api/v1/loans/#{loan.id}"

      loan_response = JSON.parse(response.body)

      assert_response :success
      expect(response).to be_success
      expect(loan_response['id']).to eq(1)
      expect(loan_response['funded_amount']).to eq(ApplicationController.helpers.number_to_currency(loan.funded_amount))
      expect(loan_response['outstanding_balance']).to eq(ApplicationController.helpers.number_to_currency(outstanding_balance))
      assert(loan_response['created_at'])
      assert(loan_response['updated_at'])
    end
  end
end
