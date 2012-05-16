FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.title }
    body { Faker::Lorem.paragraphs.join("\n\n") }
    published true
  end
end
