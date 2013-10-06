# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item, class: Item do
    item_info_id 1
    houdd_user_id 1
    dp 1
    quality 1
    built_point 0
    active_flg false
  end

  factory :item_active, class: Item do
    item_info_id 1
    houdd_user_id 1
    dp 1
    quality 1
    built_point 10
    active_flg true
  end
end
