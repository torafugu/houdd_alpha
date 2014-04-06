# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :production_queue do
    houdd_user nil
    symbol "MyString"
    queue_id 1
    priority 1
    allotment 1
    destroy_flg false
  end
end
