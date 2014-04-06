# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_squad_trail do
    trial_move_turn nil
    trial_squad nil
    from_x 1
    from_y 1
    to_x 1
    to_y 1
  end
end
