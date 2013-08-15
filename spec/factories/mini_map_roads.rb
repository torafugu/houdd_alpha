# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mini_map_road, class: MiniMapRoad do
    start_mini_map_id 1
    end_mini_map_id 2
    distance 1
    level 1
    built_point 0
    active_flg false
  end

  factory :mini_map_road_active1, class: MiniMapRoad do
    start_mini_map_id 2
    end_mini_map_id 3
    distance 1
    level 1
    built_point 0
    active_flg true
  end

  factory :mini_map_road_active2, class: MiniMapRoad do
    start_mini_map_id 3
    end_mini_map_id 4
    distance 1
    level 1
    built_point 0
    active_flg true
  end
end
