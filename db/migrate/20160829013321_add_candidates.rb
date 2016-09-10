class AddCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.references :account, null: false, index: true 
      t.integer :rating, default: 1500
    end
  end
end
