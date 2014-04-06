# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_mob_status do
    trial_move_turn nil
    trial_mob nil
    end_hp 1
    end_sp 1
    end_status "MyString"
  end
end
