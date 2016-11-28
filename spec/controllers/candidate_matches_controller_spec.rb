require 'rails_helper'
include ControllerHelper

RSpec.describe CandidateMatchesController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      user = login
      candidate = create(:candidate, user: user)

      pending_matches = create_list(:candidate_match, 5, candidate: candidate, reply: CandidateMatch::PENDING)
      create_list(:candidate_match, 2, candidate: candidate, reply: CandidateMatch::NO)

      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)

      expect(assigns(:candidate_matches)).to eq(pending_matches)
    end
  end
end
