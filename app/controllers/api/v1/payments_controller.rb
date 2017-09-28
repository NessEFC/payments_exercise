class Api::V1::PaymentsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render json: Loan.find(params[:loan_id]).payments
  end

  def create
    loan = Loan.find(params[:loan_id])
    payment = loan.payments.new(payment_params)

    if payment.save
      loan.update_outstanding_balance(payment.amount)
      render json: payment
    else
      render status: 400, json: {
        errors: payment.errors.full_messages
      }.to_json
    end
  end

  private

    def payment_params
      params.permit(:amount)
    end

end
