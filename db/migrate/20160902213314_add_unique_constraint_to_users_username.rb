class AddUniqueConstraintToUsersUsername < ActiveRecord::Migration[5.0]
  def change
    execute "ALTER TABLE users ADD CONSTRAINT check_unique_username UNIQUE(username);"
  end
end
