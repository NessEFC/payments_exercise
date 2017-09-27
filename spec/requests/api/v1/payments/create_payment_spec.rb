require 'rails_helper'

RSpec.describe 'Create a payment for a given loan', type: :request do
  context 'when payment is less than balance' do
    it 'successfully creates the payment' do
      loan = create(:loan)
      payment_amount = loan.funded_amount/2

      post "/api/v1/loans/#{loan.id}/payments", { amount: payment_amount }

      payment = Payment.last

      assert_response :success
      expect(response).to be_success
      expect(payment.amount).to eq(payment_amount)
      expect(payment.loan_id).to eq(loan.id)
      assert(payment.created_at)
      assert(payment.updated_at)
    end
  end
end
