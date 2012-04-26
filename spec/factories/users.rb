FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email("user_#{n}") }

    password 'password'
    password_confirmation { password }

    gender { ['male', 'female'].sample }
    age { (15..99).to_a.sample }

    factory :admin_user do
      admin true
    end
  end
end
