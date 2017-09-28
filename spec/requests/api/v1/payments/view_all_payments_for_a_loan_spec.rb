require 'rails_helper'

RSpec.describe 'View all payments for a given loan', type: :request do
  it 'displays all payments' do
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

    get "/api/v1/loans/#{loan.id}/payments"

    payments = JSON.parse(response.body)

    assert_response :success
    expect(response).to be_success
    expect(payments).to be_an(Array)
    expect(payments.count).to eq(3)

    expect(payments[0]['amount']).to eq(ApplicationController.helpers.number_to_currency(amount_1))
    expect(payments[0]['payment_date']).to eq(payment_1.created_at.strftime("%A, %d %b %Y"))

    expect(payments[1]['amount']).to eq(ApplicationController.helpers.number_to_currency(amount_2))
    expect(payments[1]['payment_date']).to eq(payment_2.created_at.strftime("%A, %d %b %Y"))

    expect(payments[2]['amount']).to eq(ApplicationController.helpers.number_to_currency(amount_3))
    expect(payments[2]['payment_date']).to eq(payment_3.created_at.strftime("%A, %d %b %Y"))
  end
end
