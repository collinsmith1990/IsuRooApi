require 'rails_helper'
include ControllerHelper

RSpec.describe CandidateMatchesController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      candidate = create(:candidate)
      login(candidate.user)

      matches = create_list(:candidate_match, 5, candidate: candidate)

      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)

      expect(assigns(:candidate_matches)).to eq(matches)
    end

    describe "filters" do
      describe "pending" do
        it "should return only the pending candidate matches" do
          candidate = create(:candidate)
          pending = create_list(:candidate_match, 3, candidate: candidate, reply: CandidateMatch::PENDING)
          create_list(:candidate_match, 2, candidate: candidate, reply: CandidateMatch::YES)

          login(candidate.user)
          get :index, params: { filters: [CandidateMatchOptions::PENDING_FILTER] }

          expect(assigns(:candidate_matches)).to eq(pending)
        end
      end

      describe "yes" do
        it "should return only the yes candidate matches" do
          candidate = create(:candidate)
          yes = create_list(:candidate_match, 3, candidate: candidate, reply: CandidateMatch::YES)
          create_list(:candidate_match, 2, candidate: candidate, reply: CandidateMatch::NO)

          login(candidate.user)
          get :index, params: { filters: [CandidateMatchOptions::YES_FILTER] }

          expect(assigns(:candidate_matches)).to eq(yes)
        end
      end

      describe "no" do
        it "should return only the no candidate matches" do
          candidate = create(:candidate)
          no = create_list(:candidate_match, 3, candidate: candidate, reply: CandidateMatch::NO)
          create_list(:candidate_match, 2, candidate: candidate, reply: CandidateMatch::YES)

          login(candidate.user)
          get :index, params: { filters: [CandidateMatchOptions::NO_FILTER] }

          expect(assigns(:candidate_matches)).to eq(no)
        end
      end

      describe "expired" do
        it "should return only the expired candidate matches" do
          candidate = create(:candidate)
          expired = create_list(:candidate_match, 3, candidate: candidate, reply: CandidateMatch::EXPIRED)
          create_list(:candidate_match, 2, candidate: candidate, reply: CandidateMatch::YES)

          login(candidate.user)
          get :index, params: { filters: [CandidateMatchOptions::EXPIRED_FILTER] }

          expect(assigns(:candidate_matches)).to eq(expired)
        end
      end
    end
  end
end
