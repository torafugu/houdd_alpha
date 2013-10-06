# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status_mod_inv do
    type ""
    status_mod nil
    owner_id 1
    num_of_tgt 1
    duration 1
  end
end
