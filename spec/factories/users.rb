FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email("user_#{n}") }

    password 'password'
    password_confirmation { password }
  end
end
