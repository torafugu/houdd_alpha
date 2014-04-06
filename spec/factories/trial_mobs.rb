# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trial_mob do
    trial_squad nil
    mob_id 1
    name "MyString"
    job_name "MyString"
    max_hp 1
    max_sp 1
  end
end
