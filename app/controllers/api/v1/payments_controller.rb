class Api::V1::PaymentsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    loan = Loan.find(params[:loan_id])
    payment = loan.payments.new(payment_params)

    if payment.save
      render json: payment
    end
  end

  private

    def payment_params
      params.permit(:amount)
    end

end
