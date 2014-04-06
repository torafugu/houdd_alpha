# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specie do
    family nil
    name "MyString"
    longevity 1
    prolificacy 1.5
    growth_rate 1.5
    food_cost 1
    str 1
    dex 1
    con 1
    int 1
    wis 1
    cha 1
    mutation_rate 1.5
    phys_def 1
    skill_def 1
    ele_fw 1
    ele_ld 1
    skill nil
  end
end
