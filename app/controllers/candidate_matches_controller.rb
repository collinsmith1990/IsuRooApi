class CandidateMatchesController < ApplicationController
  options_klass CandidateMatchOptions

  def index
    @candidate_matches = options.merge(current_user.candidate.matches)

    render json: @candidate_matches
  end
end
