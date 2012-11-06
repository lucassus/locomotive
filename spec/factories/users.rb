FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email("user_#{n}") }

    password 'password'
    password_confirmation { password }

    admin false
    suspended false

    trait :admin do
      admin true
    end

    trait :suspended do
      suspended true
    end

    trait :with_facebook_account do
      after(:create) do |user|
        create(:user_account, :facebook, user: user)
      end
    end
  end
end
