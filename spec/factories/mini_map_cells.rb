# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mini_map_cell, class: MiniMapCell do
    mini_map nil
    x 1
    y 1
    terrain nil
    sp_resource nil
    construction nil
    built_point 1
    const_active_flg false
    capital_flg false
  end

  factory :mini_map_cell_constrcution_1, class: MiniMapCell do
    mini_map_id 1
    x 1
    y 1
    terrain nil
    sp_resource nil
    construction_id 1
    built_point 0
    const_active_flg false
    capital_flg false
  end
end
