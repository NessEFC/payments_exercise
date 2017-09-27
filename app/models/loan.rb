class Loan < ActiveRecord::Base
  before_create :set_default_outstanding_balance

  has_many :payments

  def update_outstanding_balance(payment_amount)
    new_balance = self.outstanding_balance - payment_amount
    self.update_attributes(outstanding_balance: new_balance)
  end

  private

    def set_default_outstanding_balance
      self.outstanding_balance = self.funded_amount
    end

end
