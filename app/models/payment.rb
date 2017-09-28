class Payment < ActiveRecord::Base
  validates :amount, presence: true
  validates :loan, presence: true

  belongs_to :loan

  validate :validate_payment_amount

  private

    def validate_payment_amount
      if loan.outstanding_balance < self.amount
        errors.add(:amount, "of payment must not exceed the outstanding loan balance")
      end
    end

end
