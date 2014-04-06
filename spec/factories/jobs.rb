# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    type_symbol "MyString"
    name "MyString"
    growth_penalty 1.5
    wepon_lvl 1
    armor_lvl 1
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
