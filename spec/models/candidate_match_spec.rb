require 'rails_helper'

RSpec.describe CandidateMatch, :type => :model do
  it "should be valid" do
    expect(build(:candidate_match)).to be_valid
  end

  it "should be unique match" do
    candidate_match = create(:candidate_match)
    duplicate = build(:candidate_match, candidate: candidate_match.candidate, match: candidate_match.match)
    expect(duplicate).to be_invalid
  end

  it "should have reply constants" do
    expect(CandidateMatch::PENDING).to eq('p')
    expect(CandidateMatch::YES).to eq('y')
    expect(CandidateMatch::NO).to eq('n')
    expect(CandidateMatch::EXPIRED).to eq('e')
  end

  describe "match" do
    it "isnt candidate" do
      candidate = create(:candidate)
      expect(build(:candidate_match, candidate: candidate, match: candidate)).to be_invalid
    end
  end

  describe "reply" do
    it "should be in ['p', 'y', 'n', 'e']" do
      expect(build(:candidate_match, reply: 'x')).to be_invalid
    end
  end

  describe "pending" do
    it "should return with all pending matches for a given candidate" do
      candidate = create(:candidate)
      pending = create_list(:candidate_match, 3, candidate: candidate, reply: CandidateMatch::PENDING)
      create_list(:candidate_match, 2, candidate: candidate, reply: CandidateMatch::NO)

      expect(CandidateMatch.pending).to eq(pending)
    end
  end

  describe "yes" do
    it "should return with all yes matches for a given candidate" do
      candidate = create(:candidate)
      yes = create_list(:candidate_match, 3, candidate: candidate, reply: CandidateMatch::YES)
      create_list(:candidate_match, 2, candidate: candidate, reply: CandidateMatch::NO)

      expect(CandidateMatch.yes).to eq(yes)
    end
  end

  describe "no" do
    it "should return with all no matches for a given candidate" do
      candidate = create(:candidate)
      no = create_list(:candidate_match, 3, candidate: candidate, reply: CandidateMatch::NO)
      create_list(:candidate_match, 2, candidate: candidate, reply: CandidateMatch::YES)

      expect(CandidateMatch.no).to eq(no)
    end
  end

  describe "expired" do
    it "should return with all expired matches for a given candidate" do
      candidate = create(:candidate)
      expired = create_list(:candidate_match, 3, candidate: candidate, reply: CandidateMatch::EXPIRED)
      create_list(:candidate_match, 2, candidate: candidate, reply: CandidateMatch::YES)

      expect(CandidateMatch.expired).to eq(expired)
    end
  end
end
