class AddAdminAndModeratorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :moderator, :boolean
  end
end
