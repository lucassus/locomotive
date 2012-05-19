FactoryGirl.define do
  factory :static_page do
    content { Faker::Lorem.paragraphs.join("\n") }
  end
end
