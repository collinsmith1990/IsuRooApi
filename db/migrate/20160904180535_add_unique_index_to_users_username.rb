class AddUniqueIndexToUsersUsername < ActiveRecord::Migration[5.0]
  def change
    execute "ALTER TABLE users DROP CONSTRAINT check_unique_username;"
    execute "CREATE UNIQUE INDEX unique_username_on_users ON users (lower(username));"
  end
end
