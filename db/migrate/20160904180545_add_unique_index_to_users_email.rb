class AddUniqueIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def change
    execute "CREATE UNIQUE INDEX unique_email_on_users ON users (lower(email));"
  end
end
