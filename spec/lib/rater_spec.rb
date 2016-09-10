require 'rails_helper'

RSpec.describe Rater, :type => :class do
  it "should have a candidate" do
    candidate = create(:candidate)
    expect(Rater.new(candidate).candidate).to eq(candidate)
  end

  describe "likes" do
    it "should decrease the candidates rating and increase the targets rating" do
      candidate, target = create_list(:candidate, 2)

      before_candidate_rating = candidate.rating
      before_target_rating = target.rating

      Rater.new(candidate).likes(target)

      expect(candidate.rating).to be < before_candidate_rating
      expect(target.rating).to be > before_target_rating
    end

    it "should increase games_played of both candidates by 1" do
      candidate, target = create_list(:candidate, 2, games_played: 2)

      expect{Rater.new(candidate).likes(target)}.to change{candidate.games_played}.by(1)
                                               .and change{candidate.games_played}.by(1)
    end
  end

  describe "dislikes" do
    it "should increase the candidates rating and decrease the targets rating" do
      candidate, target = create_list(:candidate, 2)
      before_candidate_rating = candidate.rating
      before_target_rating = target.rating

      Rater.new(candidate).dislikes(target)

      expect(candidate.rating).to be > before_candidate_rating
      expect(target.rating).to be < before_target_rating
    end

    it "should increase games_played of both candidates by 1" do
      candidate, target = create_list(:candidate, 2, games_played: 2)

      expect{Rater.new(candidate).dislikes(target)}.to change{candidate.games_played}.by(1)
                                                  .and change{candidate.games_played}.by(1)
    end
  end
end
