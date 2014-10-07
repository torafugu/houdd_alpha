# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_squad do
    trial nil
    squad_id 1
    name "MyString"
    intruder_flg false
  end
end
