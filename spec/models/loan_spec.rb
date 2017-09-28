require 'rails_helper'

RSpec.describe Loan, type: :model do
  it 'has a valid factory' do
    expect(build(:loan)).to be_valid
  end

  let(:loan) { build(:loan) }

  describe 'validations' do
    it { expect(loan).to validate_presence_of(:funded_amount) }
    it { expect(loan).to validate_presence_of(:outstanding_balance) }
  end

  describe 'attributes' do
    it { expect(loan).to respond_to(:funded_amount) }
    it { expect(loan).to respond_to(:outstanding_balance) }
  end

  describe 'associations' do
    it { expect(loan).to have_many(:payments) }
  end

  describe 'public instance methods' do
    let(:loan) { create(:loan, funded_amount: 100.00) }
    it { expect(loan.outstanding_balance).to eq(loan.funded_amount) }

    it 'updates the balance' do
      loan.update_outstanding_balance(20.00)
      expect(loan.outstanding_balance).to eq(80.00)
    end
  end

  describe 'callbacks' do
    it { expect(loan).to callback(:set_default_outstanding_balance).before(:create) }
  end

  describe 'private instance methods' do
    let(:loan) { create(:loan) }
    it { expect(loan.funded_amount).to eq(loan.outstanding_balance) }
  end

end
