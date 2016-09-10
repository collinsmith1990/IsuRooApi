FactoryGirl.define do
  sequence(:username) { |n| "LonelyBot#{n}" }
  sequence(:email) { |n| "LonelyBot#{n}@example.com" }

  factory :user do
    username
    email
    password "testpass"
  end
end
