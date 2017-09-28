require 'rails_helper'

RSpec.describe Payment, type: :model do
  it 'has a valid factory' do
    expect(build(:payment)).to be_valid
  end

  let(:payment) { build(:payment) }

  describe 'attributes' do
    it { expect(payment).to respond_to(:amount) }
    it { expect(payment).to respond_to(:loan_id) }
  end

  describe 'associations' do
    it { expect(payment).to belong_to(:loan) }
  end
end
