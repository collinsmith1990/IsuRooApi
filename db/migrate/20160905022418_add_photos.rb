class AddPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :content, null: false
      t.references :candidate, null: false, index: true
    end
  end
end
