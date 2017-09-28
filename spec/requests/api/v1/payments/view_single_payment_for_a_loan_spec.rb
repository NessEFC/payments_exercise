require 'rails_helper'

RSpec.describe 'View single payment for a given loan', type: :request do
  it 'displays a payment' do
    loan = create(:loan, funded_amount: 1000.00)
    amount_1 = 100.00
    amount_2 = 200.00
    amount_3 = 500.00

    post "/api/v1/loans/#{loan.id}/payments", { amount: amount_1 }
    payment_1 = Payment.last

    post "/api/v1/loans/#{loan.id}/payments", { amount: amount_2 }
    payment_2 = Payment.last

    post "/api/v1/loans/#{loan.id}/payments", { amount: amount_3 }
    payment_3 = Payment.last

    get "/api/v1/payments/#{payment_2.id}"

    payment = JSON.parse(response.body)

    assert_response :success
    expect(response).to be_success
    expect(payment).to be_a(Hash)
    expect(payment.keys.count).to eq(2)

    expect(payment['amount']).to eq(ApplicationController.helpers.number_to_currency(amount_2))
    expect(payment['payment_date']).to eq(payment_2.created_at.strftime("%A, %d %b %Y"))
  end
end
