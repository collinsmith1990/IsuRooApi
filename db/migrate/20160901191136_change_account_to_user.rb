class ChangeAccountToUser < ActiveRecord::Migration[5.0]
  def change
    rename_column :accounts,:display_name, :username
    rename_table :accounts, :users
  end
end
