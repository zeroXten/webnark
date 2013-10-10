class AddModeratedToService < ActiveRecord::Migration
  def change
    add_column :services, :moderated, :boolean, default: false
  end
end
