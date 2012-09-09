FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post title #{n}" }
    sequence(:body) { |n| "Post body #{n}" }
    published { [true, false].sample }

    trait :published do
      published true
    end

    trait :unpublished do
      published false
    end
  end
end
