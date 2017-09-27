class PaymentSerializer < ActiveModel::Serializer
  attributes :amount, :payment_date

  def payment_date
    object.created_at.strftime("%A, %d %b %Y")
  end

  def amount
    ApplicationController.helpers.number_to_currency(object.amount)
  end

end
