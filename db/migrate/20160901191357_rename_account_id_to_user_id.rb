class RenameAccountIdToUserId < ActiveRecord::Migration[5.0]
  def change
    rename_column :candidates, :account_id, :user_id
  end
end
