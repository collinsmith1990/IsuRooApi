require 'rails_helper'

RSpec.describe CandidateOptions, :type => :options do
  it "should be initialized with a params hash" do
    options = CandidateOptions.new({order: "match"})

    expect(options.order).to eq('match')
  end

  context "merge" do
    it "should return all records" do
      candidates = create_list(:candidate, 5)
      options = CandidateOptions.new

      results = options.merge(candidates)

      expect(candidates).to eq(results)
    end

    context "order" do
      describe "match" do
        it "should return all records orded by match" do
          candidate = create(:candidate, rating: 1500)

          candidates = [create(:candidate, rating: 1450),
                        create(:candidate, rating: 1300),
                        create(:candidate, rating: 1525)]

          expected_order = [candidate, candidates[2], candidates[0], candidates[1]]
          options = CandidateOptions.new({order: CandidateOptions::MATCH_ORDER, candidate_id: candidate.id})

          results = options.merge(Candidate.all)

          expect(results).to eq(expected_order)
        end
      end
    end

    context "filters" do
      describe "f" do
        it "should return all female records" do
          create_list(:candidate, 3, gender: Candidate::MALE)
          females = create_list(:candidate, 2, gender: Candidate::FEMALE)

          options = CandidateOptions.new({filters: [CandidateOptions::FEMALE_FILTER]})

          results = options.merge(Candidate.all)

          expect(results).to match_array(females)
        end
      end

      describe "['m', 'f']" do
        it "should return no records" do
          create_list(:candidate, 5)

          options = CandidateOptions.new({filters: [CandidateOptions::MALE_FILTER, CandidateOptions::FEMALE_FILTER]})

          results = options.merge(Candidate.all)

          expect(results).to match_array([])
        end
      end

      describe "has_bio" do
        it "should return candidates with a bio" do
          candidates_with_bio = create_list(:candidate, 3, biography: "Has Bio")
          create_list(:candidate, 2, biography: nil)

          options = CandidateOptions.new({filters: [CandidateOptions::HAS_BIO_FILTER]})

          results = options.merge(Candidate.all)

          expect(results).to match_array(candidates_with_bio)
        end
      end

      describe "has_photo" do
        it "should return candidates with photos" do
          candidates_with_photo = create_list(:candidate, 3)
          candidates_with_photo.each {|candidate| create(:photo, candidate: candidate)}
          create_list(:candidate, 2)

          options = CandidateOptions.new({filters: [CandidateOptions::HAS_PHOTO_FILTER]})

          results = options.merge(Candidate.all)

          expect(results).to match_array(candidates_with_photo)
        end
      end
    end
  end
end


