# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gene do
    specie nil
    dominance_flg false
    prolificacy_mod 1.5
    longevity_mod 1.5
    growth_mod 1.5
    food_cost_mod 1.5
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
  end
end
