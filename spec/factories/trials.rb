# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial do
    mini_map nil
    map_name "MyString"
    guard_mission_id 1
    intruder_mission_id 1
    occured_at 1
  end
end
