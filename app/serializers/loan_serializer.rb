class LoanSerializer < ActiveModel::Serializer
  attributes :id, :funded_amount, :outstanding_balance, :created_at, :updated_at

  def funded_amount
    ApplicationController.helpers.number_to_currency(object.funded_amount)
  end

  def outstanding_balance
    ApplicationController.helpers.number_to_currency(object.outstanding_balance)
  end

end
