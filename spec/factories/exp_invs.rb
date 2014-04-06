# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exp_inv do
    type ""
    mob nil
    owner_id 1
    level 1
    exp 1
  end
end
