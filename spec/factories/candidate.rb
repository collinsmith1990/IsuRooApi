FactoryGirl.define do
  factory :candidate do
    association :user
    sequence(:gender) {|n| n % 2 == 0 ? Candidate::MALE : Candidate::FEMALE}
    biography "I'm just a lonely bot"
  end

  factory :varied_rating_candidate, class: Candidate do
    association :user
    sequence(:rating) { rand(1300..2000) }
    sequence(:gender) {|n| n % 2 == 0 ? Candidate::MALE : Candidate::FEMALE}
    biography "I'm just a lonely bot"
  end
end
