# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_battle_log do
    trial_move_turn nil
    trial_mob nil
    vpos 1
    target_mob_id 1
    target_dead_flg false
    damage 1
    method_txt "MyString"
  end
end
