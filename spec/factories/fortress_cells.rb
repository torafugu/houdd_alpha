# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fortress_cell do
    mini_map nil
    symbol "MyString"
    x 1
    y 1
    trap_id 1
    squad_id 1
  end
end
