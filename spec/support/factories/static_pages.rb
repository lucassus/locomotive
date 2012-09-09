FactoryGirl.define do
  factory :static_page do
    name 'about'
    content { Faker::Lorem.paragraphs.join("\n") }
  end
end
