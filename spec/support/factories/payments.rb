FactoryGirl.define do
  factory :payment do
    amount (1..100).to_a.sample
    loan
  end
end
