# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_battle_turn do
    trial_battle_set nil
    log "MyText"
  end
end
