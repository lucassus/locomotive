FactoryGirl.define do
  factory :post do
    title { Faker::Name.title }
    body { Faker::Lorem.paragraphs.join("\n") }
    published { [true, false].sample }

    trait :published do
      published true
    end

    trait :unpublished do
      published false
    end
  end
end
