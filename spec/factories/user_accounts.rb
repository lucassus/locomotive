FactoryGirl.define do
  factory :user_account do
    user

    provider 'facebook'
    uid 'facebook-user-id'

    trait :facebook do
      provider 'facebook'
    end

    trait :twitter do
      provider 'twitter'
    end

    trait :google do
      provider 'google'
    end
  end
end
