# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :terrain do
    symbol "MyString"
    name "MyString"
    food 1
    production 1
    money 1
    frequency_rate 1
    continuity_mod 1
  end
end
