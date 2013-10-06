# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :specie_job_inv do
    specie nil
    job nil
    frequency_rate 1
  end
end
