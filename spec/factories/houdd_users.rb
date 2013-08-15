# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :houdd_user do
    name "Test"
    admin_flg false
    login_id "Test"
    login_pw "Test"
    last_login_at "2013-08-03 18:42:34"
    active_flg true
    allot_for_item 34
    allot_for_const 33
    allot_for_research 33
  end
end
