FactoryGirl.define do
  factory :post do
    title { Faker::Name.title }
    body { Faker::Lorem.paragraphs.join("\n") }
    published { [true, false].sample }

    factory :published_post do
      published true
    end

    factory :unpublished_post do
      published false
    end
  end
end
