# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sp_resource do
    terrain nil
    symbol "MyString"
    name "MyString"
    food 1
    production 1
    money 1
    frequency_rate 1
  end
end
