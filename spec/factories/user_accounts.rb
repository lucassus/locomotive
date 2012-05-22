FactoryGirl.define do
  factory :user_account do
    user

    provider 'facebook'
    uid 'facebook-user-id'

    factory :facebook_account do
      provider UserAccount::FACEBOOK
    end

    factory :twitter_account do
      provider UserAccount::TWITTER
    end
  end
end
