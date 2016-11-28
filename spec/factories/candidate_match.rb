FactoryGirl.define do
  factory :candidate_match do
    association :candidate
    association :match, factory: :candidate
  end
end

