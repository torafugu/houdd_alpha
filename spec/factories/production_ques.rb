# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :production_que, class: ProductionQue do
    houdd_user_id 1
    symbol "MyString"
    que_id 1
    priority 1
    allotment 1
    destroy_flg false
  end

  factory :production_que_for_mini_map_road_create, class: ProductionQue do
    houdd_user_id 1
    symbol "mini_map_road"
    que_id 1
    priority 1
    allotment 1
    destroy_flg false
  end

  factory :production_que_for_mini_map_road_destroy, class: ProductionQue do
    houdd_user_id 1
    symbol "mini_map_road"
    que_id 1
    priority 1
    allotment 1
    destroy_flg true
  end

  factory :production_que_for_construction_create, class: ProductionQue do
    houdd_user_id 1
    symbol "mini_map_cell"
    que_id 1
    priority 1
    allotment 1
    destroy_flg false
  end
end
