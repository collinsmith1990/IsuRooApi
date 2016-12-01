require 'rails_helper'

RSpec.describe Candidate, :type => :model do
  it "should be valid" do
    expect(build(:candidate)).to be_valid
  end

  it "should have an associated user" do
    expect(build(:candidate, user_id: nil)).to be_invalid
  end

  describe "games_played" do
    it "should be an integer" do
      expect(build(:candidate, games_played: 1.1)).to be_invalid
    end

    it "should be >= 0" do
      expect(build(:candidate, games_played: -1)).to be_invalid
      expect(build(:candidate, games_played: 0)).to be_valid
      expect(build(:candidate, games_played: 1)).to be_valid
    end
  end

  describe "gender" do
    it "should be required" do
      expect(build(:candidate, gender: nil)).to be_invalid
    end

    it "should be a valid character" do
      expect(build(:candidate, gender: 'x')).to be_invalid
    end
  end

  describe "biography" do
    it "should not be required" do
      expect(build(:candidate, biography: nil)).to be_valid
    end

    it "should be less than 500 charactes" do
      expect(build(:candidate, biography: "z" * 501)).to be_invalid
    end
  end

  #describe "matches" do
    #it "should return all candidates within 100 rating of the provided candidate" do
      ## We are looking for matches for this candidate
      #candidate = create(:candidate, rating: 1600)

      #included_results = [create(:candidate, rating: 1650),
                          #create(:candidate, rating: 1500)]

      ##This candidate should be excluded from the results since the rating is out of range
      #create(:candidate, rating: 1400)

      #matches = Candidate.matches(candidate)

      #expect(matches).to match_array(included_results)
    #end
  #end

  describe "male" do
    it "shuld return all male candidates" do
      males = create_list(:candidate, 3, gender: Candidate::MALE)
      create_list(:candidate, 2, gender: Candidate::FEMALE)

      expect(Candidate.male).to match_array(males)
    end
  end

  describe "female" do
    it "shuld return all female candidates" do
      females = create_list(:candidate, 3, gender: Candidate::FEMALE)
      create_list(:candidate, 2, gender: Candidate::MALE)

      expect(Candidate.female).to match_array(females)
    end
  end

  describe "has_bio" do
    it "shuld return all candidates with a bio" do
      has_bio = create_list(:candidate, 3, biography: "My personal bio.")
      create_list(:candidate, 2, biography: nil)

      expect(Candidate.has_bio).to match_array(has_bio)
    end
  end

  describe "has_photo" do
    it "shuld return all candidates with at least one photo" do
      has_photo = create_list(:candidate, 3)
      has_photo.each {|candidate| create(:photo, candidate: candidate)}
      create_list(:candidate, 2, biography: nil)

      expect(Candidate.has_photo).to match_array(has_photo)
    end
  end

  #describe "match_order" do
    #it "should be ascending order of difference in rating" do
      #candidate = create(:candidate, rating: 1700)
      #candidates = [create(:candidate, rating: 1600),
                    #create(:candidate, rating: 1300),
                    #create(:candidate, rating: 1800),
                    #create(:candidate, rating: 1750)]
      #expected_order = [candidate, candidates[3], candidates[2], candidates[0], candidates[1]]

      #expect(Candidate.match_order(candidate)).to match_array(expected_order)
    #end
  #end

  describe "rating_order" do
    it "should be descending order of rating" do
      candidates = [create(:candidate, rating: 1600),
                    create(:candidate, rating: 1300),
                    create(:candidate, rating: 1800),
                    create(:candidate, rating: 1750)]
      expected_order = [candidates[2], candidates[3], candidates[0], candidates[1]]

      expect(Candidate.rating_order).to match_array(expected_order)
    end
  end

  describe "likes" do
    it "should decrease the candidates rating and increase the targets rating" do
      candidate, target = create_list(:candidate, 2)

      before_candidate_rating = candidate.rating
      before_target_rating = target.rating

      candidate.likes(target)

      expect(candidate.rating).to be < before_candidate_rating
      expect(target.rating).to be > before_target_rating
    end

    it "should increase games_played of both candidates by 1" do
      candidate, target = create_list(:candidate, 2, games_played: 2)

      expect{candidate.likes(target)}.to change{candidate.games_played}.by(1)
                                    .and change{candidate.games_played}.by(1)
    end
  end

  describe "dislikes" do
    it "should increase the candidates rating and decrease the targets rating" do
      candidate, target = create_list(:candidate, 2)
      before_candidate_rating = candidate.rating
      before_target_rating = target.rating

      candidate.dislikes(target)

      expect(candidate.rating).to be > before_candidate_rating
      expect(target.rating).to be < before_target_rating
    end

    it "should increase games_played of both candidates by 1" do
      candidate, target = create_list(:candidate, 2, games_played: 2)

      expect{candidate.dislikes(target)}.to change{candidate.games_played}.by(1)
                                       .and change{candidate.games_played}.by(1)
    end
  end

  describe "matches" do
    it "should return candidate_matches" do
      candidate = create(:candidate)
      matches = create_list(:candidate_match, 5, candidate: candidate)

      expect(candidate.matches).to eq(matches)
    end
  end
end
