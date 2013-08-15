# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
    factory :mini_map, class: MiniMap do
    houdd_user_id 1
    name "Test"
    size 5
    hq_flg false
    type_symbol "plain"
    find_root_flg false
  end

  factory :mini_map_hq, class: MiniMap do
    houdd_user_id 2
    name "Test(HQ)"
    size 10
    hq_flg true
    type_symbol "plain"
    find_root_flg false
  end

  factory :mini_map_not_hq, class: MiniMap do
    houdd_user_id 2
    name "Test(Not HQ)"
    size 5
    hq_flg false
    type_symbol "plain"
    find_root_flg false
  end
end
