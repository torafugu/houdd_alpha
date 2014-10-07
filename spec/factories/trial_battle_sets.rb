# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_battle_set do
    trial_move_turn nil
    attacker_squad nil
    defender_squad nil
    distance 1
  end
end
