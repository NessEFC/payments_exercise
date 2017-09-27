class Api::V1::PaymentsController < ApplicationController

  def create
    loan = Loan.find(params[:loan_id])
    payment = loan.payments.new(payment_params)
  end

  private

    def payment_params
      params.require(:payment).permit(:amount)
    end

end
