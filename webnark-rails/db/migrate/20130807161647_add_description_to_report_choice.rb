class AddDescriptionToReportChoice < ActiveRecord::Migration
  def change
    add_column :report_choices, :description, :text
  end
end
