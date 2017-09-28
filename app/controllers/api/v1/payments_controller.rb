class Api::V1::PaymentsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def show
    render json: Payment.find(params[:id])
  end
  
end
