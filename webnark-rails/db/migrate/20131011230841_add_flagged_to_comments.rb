class AddFlaggedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :flagged, :boolean
  end
end
