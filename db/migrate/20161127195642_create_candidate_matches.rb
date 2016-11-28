class CreateCandidateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :candidate_matches do |t|
      t.references :candidate, null: false
      t.references :match, class: :candidate, null: false
      t.column :reply, 'char(1)', null: false, default: 'p'

      t.timestamps

    end

    add_index :candidate_matches, [:candidate_id, :match_id], unique: true

    execute "ALTER TABLE candidate_matches ADD CONSTRAINT check_valid_reply CHECK (reply IN ('p', 'y', 'n', 'e'));"
    execute "ALTER TABLE candidate_matches ADD CONSTRAINT check_candidate_is_not_match CHECK (candidate_id != match_id);"
  end
end
