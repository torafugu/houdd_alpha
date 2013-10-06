# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill_category do
    type_sym "MyString"
    element_sym "MyString"
  end
end
