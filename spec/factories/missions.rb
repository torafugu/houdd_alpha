# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mission do
    houdd_user nil
    mini_map nil
    category_symbol "MyString"
    mission_strategy nil
    status_symbol "MyString"
    start_houdd_time "9.99"
    end_houdd_time "9.99"
  end
end
