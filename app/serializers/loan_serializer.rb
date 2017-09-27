class LoanSerializer < ActiveModel::Serializer
  attributes :id, :funded_amount, :created_at, :updated_at

  def funded_amount
    ApplicationController.helpers.number_to_currency(object.funded_amount)
  end

end
