# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item_info do
    type_symbol "MyString"
    element_symbol "MyString"
    name "MyString"
    num_of_tgt 1
    hit_accuracy 1
    range 1
    damage 1
    heal 1
    str_mod 1.5
    dex_mod 1.5
    con_mod 1.5
    int_mod 1.5
    wis_mod 1.5
    cha_mod 1.5
    ele_fw_mod 1.5
    ele_ld_mod 1.5
    phys_def_mod 1.5
    skill_def_mod 1.5
    duration 1
    family nil
    weight_level 1
    max_dp 1
    rq_prod_point 1
    atk_cycle 1
    research_level 1
  end
end
