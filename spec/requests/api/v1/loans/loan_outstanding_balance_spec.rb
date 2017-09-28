require 'rails_helper'

RSpec.describe 'Show the outstanding balance', type: :request do
  context 'for a single loan' do
    it 'displays the balance' do
      loan = create(:loan, funded_amount: 1000.00)
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

  context 'for all loans' do
    it 'displays all balances' do
      loan_1, loan_2 = create_list(:loan, 2, funded_amount: 1000.00)
      payment_1 = 100.00
      payment_2 = 200.00
      payment_3 = 500.00

      post "/api/v1/loans/#{loan_1.id}/payments", { amount: payment_1 }
      post "/api/v1/loans/#{loan_1.id}/payments", { amount: payment_2 }
      post "/api/v1/loans/#{loan_2.id}/payments", { amount: payment_3 }

      outstanding_balance_1 = loan_1.funded_amount - payment_1 - payment_2
      outstanding_balance_2 = loan_2.funded_amount - payment_3

      get "/api/v1/loans"

      loans = JSON.parse(response.body)

      assert_response :success
      expect(response).to be_success
      expect(loans.count).to eq(2)

      expect(loans.first['id']).to eq(1)
      expect(loans.first['funded_amount']).to eq(ApplicationController.helpers.number_to_currency(loan_1.funded_amount))
      expect(loans.first['outstanding_balance']).to eq(ApplicationController.helpers.number_to_currency(outstanding_balance_1))
      assert(loans.first['created_at'])
      assert(loans.first['updated_at'])

      expect(loans.last['id']).to eq(2)
      expect(loans.last['funded_amount']).to eq(ApplicationController.helpers.number_to_currency(loan_2.funded_amount))
      expect(loans.last['outstanding_balance']).to eq(ApplicationController.helpers.number_to_currency(outstanding_balance_2))
      assert(loans.last['created_at'])
      assert(loans.last['updated_at'])
    end
  end
end
