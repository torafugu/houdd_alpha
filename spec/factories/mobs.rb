# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mob do
    houdd_user nil
    specie nil
    father_id 1
    mother_id 1
    generation 1
    job nil
    squad nil
    name "MyString"
    gender_sym "MyString"
    age 1
    hp 1
    sp 1
    str 1
    dex 1
    con 1
    int 1
    wis 1
    cha 1
    phys_def 1
    skill_def 1
    ele_fw 1
    ele_ld 1
    natural_death_flg false
  end
end
