# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mission_queue do
    mission nil
    squad nil
    priority 1
  end
end
