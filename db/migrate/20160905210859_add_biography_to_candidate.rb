class AddBiographyToCandidate < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :biography, :string, limit: 500
  end
end
