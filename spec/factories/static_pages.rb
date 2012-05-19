FactoryGirl.define do
  factory :static_page do
    body { Faker::Lorem.paragraphs.join("\n\n") }
  end
end
