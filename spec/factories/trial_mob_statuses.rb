# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_mob_status do
    trial_battle_turn nil
    trial_mob nil
    vpos 1
    start_hp 1
    end_hp 1
    start_sp 1
    end_sp 1
    start_status "MyString"
    end_status "MyString"
  end
end
