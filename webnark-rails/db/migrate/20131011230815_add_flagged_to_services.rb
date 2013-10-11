class AddFlaggedToServices < ActiveRecord::Migration
  def change
    add_column :services, :flagged, :boolean
  end
end
