# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status_mod do
    name "MyString"
    hit_accuracy 1
    d_range 1
    x_range 1
    hp_damage 1
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
