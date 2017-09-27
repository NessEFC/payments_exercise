class Loan < ActiveRecord::Base
  before_create :set_default_outstanding_balance

  has_many :payments

  private

    def set_default_outstanding_balance
      self.outstanding_balance = self.funded_amount
    end

end
