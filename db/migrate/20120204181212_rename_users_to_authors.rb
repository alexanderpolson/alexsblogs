class RenameUsersToAuthors < ActiveRecord::Migration
  def up
    rename_table :users, :authors
  end

  def down
    rename_table :authors, :users
  end
end
