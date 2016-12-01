class CandidatesController < ApplicationController
  options_klass CandidateOptions

  def create
    @candidate = current_user.build_candidate(candidate_params)

    if @current_user.save
      render json: @candidate
    else
      render json: @candidate.errors, status: :unprocessable_entity
    end
  end

  def update
    @candidate = Candidate.find(params[:id])
    @target = Candidate.find(params[:target_id])

    likes ? @candidate.likes(@target) : @candidate.dislikes(@target)

    render json: {candidate: @candidate, target: @target}
  end


  def index
    @candidates = options.merge(Candidate.all)

    render json: @candidates
  end

  private

  def likes
    params[:likes].present? && parse_boolean(params[:likes])
  end

  def candidate_params
    params.require(:candidate).permit(:gender, :biography)
  end
end
