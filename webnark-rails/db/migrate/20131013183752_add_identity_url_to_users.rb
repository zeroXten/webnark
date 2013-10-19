class AddIdentityUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :string, :identity_url
  end
end
