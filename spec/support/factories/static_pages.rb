FactoryGirl.define do
  factory :static_page do
    name 'about'
    sequence(:content) { |n| "Page content #{n}" }
  end
end
