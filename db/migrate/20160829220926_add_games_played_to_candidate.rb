class AddGamesPlayedToCandidate < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :games_played, :integer, null: false, default: 0
  end
end
