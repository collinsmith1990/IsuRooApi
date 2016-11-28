class CandidateMatchesController < ApplicationController

  def index
    @candidate_matches = current_user.candidate.matches.pending
    render json: @candidate_matches
  end
end
