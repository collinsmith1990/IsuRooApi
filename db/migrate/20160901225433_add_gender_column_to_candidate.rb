class AddGenderColumnToCandidate < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :gender, 'char(1)', null: false, default: 'm'
    execute "ALTER TABLE candidates ADD CONSTRAINT check_valid_gender CHECK (gender IN ('m', 'f'));"
  end
end
