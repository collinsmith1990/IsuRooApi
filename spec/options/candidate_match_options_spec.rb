require 'rails_helper'

RSpec.describe CandidateMatchOptions, :type => :options do
  context "merge" do
    it "should return all records" do
      candidate_matches = create_list(:candidate_match, 5)
      options = CandidateMatchOptions.new

      results = options.merge(CandidateMatch.all)

      expect(results).to eq(candidate_matches)
    end
  end

  context "filters" do
    describe "p" do
      it "should return all pending records" do
        pending = create_list(:candidate_match, 3, reply: CandidateMatch::PENDING)
        create_list(:candidate_match, 2, reply: CandidateMatch::YES)

        options = CandidateMatchOptions.new({filters: [CandidateMatchOptions::PENDING_FILTER]})

        results = options.merge(CandidateMatch.all)

        expect(results).to eq(pending)
      end
    end

    describe "y" do
      it "should return all yes records" do
        yes = create_list(:candidate_match, 3, reply: CandidateMatch::YES)
        create_list(:candidate_match, 2, reply: CandidateMatch::PENDING)

        options = CandidateMatchOptions.new({filters: [CandidateMatchOptions::YES_FILTER]})

        results = options.merge(CandidateMatch.all)

        expect(results).to eq(yes)
      end
    end

    describe "n" do
      it "should return all no records" do
        no = create_list(:candidate_match, 3, reply: CandidateMatch::NO)
        create_list(:candidate_match, 2, reply: CandidateMatch::PENDING)

        options = CandidateMatchOptions.new({filters: [CandidateMatchOptions::NO_FILTER]})

        results = options.merge(CandidateMatch.all)

        expect(results).to eq(no)
      end
    end

    describe "e" do
      it "should return all expired records" do
        expired = create_list(:candidate_match, 3, reply: CandidateMatch::EXPIRED)
        create_list(:candidate_match, 2, reply: CandidateMatch::PENDING)

        options = CandidateMatchOptions.new({filters: [CandidateMatchOptions::EXPIRED_FILTER]})

        results = options.merge(CandidateMatch.all)

        expect(results).to eq(expired)
      end
    end
  end
end
