# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item_info do
    item_category_id 1
    size 1
    weight_level 1
    name "MyString"
    max_dp 1
    rq_prod_point 10
    research_level 1
  end
end
