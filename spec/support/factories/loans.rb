FactoryGirl.define do
  factory :loan do
    sequence :funded_amount do |n|
      (100..1000).to_a.sample + n
    end
  end
end
