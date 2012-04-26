# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :encounter do
    interest_type { Encounter::INTEREST_TYPES.sample }
  end
end
