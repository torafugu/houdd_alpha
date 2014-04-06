# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_fortress_cell do
    trial nil
    symbol "MyString"
    x 1
    y 1
    trap_flg false
    goal_flg false
  end
end
