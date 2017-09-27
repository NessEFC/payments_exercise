class AddLoanToPayments < ActiveRecord::Migration
  def change
    add_reference :payments, :loan, index: true, foreign_key: true
  end
end
