FactoryGirl.define do
  factory :user_account do
    user

    provider 'facebook'
    uid 'facebook-user-id'

    trait :facebook do
      provider UserAccount::FACEBOOK
    end

    trait :twitter do
      provider UserAccount::TWITTER
    end

    trait :google do
      provider UserAccount::GOOGLE
    end
  end
end
