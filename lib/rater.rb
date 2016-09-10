class Rater
  attr_accessor :candidate
  attr_accessor :target

  attr_accessor :candidate_player
  attr_accessor :target_player

  def initialize(candidate)
    @candidate = candidate
  end

  def likes(target)
    @target = target
    candidate_player.loses_from(target_player)
    save
  end

  def dislikes(target)
    @target = target
    candidate_player.wins_from(target_player)
    save
  end

  def candidate_player
    @candidate_player ||= Elo::Player.new(rating: candidate.rating, games_played: candidate.games_played)
  end

  def target_player
    @target_player ||= Elo::Player.new(rating: target.rating, games_played: target.games_played)
  end

  def save
    candidate.update(rating: candidate_player.rating, games_played: candidate_player.games_played)
    target.update(rating: target_player.rating, games_played: target_player.games_played)
  end
end
