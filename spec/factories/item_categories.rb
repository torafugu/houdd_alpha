# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item_category do
    type_sym "MyString"
    name "MyString"
    body_part nil
    rq_slot_num 1
  end
end
