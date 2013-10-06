# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    skill_category nil
    name "MyString"
    sp_cost 1
    research_level 1
  end
end
