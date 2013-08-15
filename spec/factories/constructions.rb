# coding: utf-8

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :construction do
    terrain nil
    symbol "test"
    name "テスト"
    food 1
    production 1
    money 1
    rq_prod_point 1
    rq_days 1
  end
end
