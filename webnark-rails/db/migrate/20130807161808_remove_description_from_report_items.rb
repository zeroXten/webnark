class RemoveDescriptionFromReportItems < ActiveRecord::Migration
  def change
    remove_column :report_choices, :description
  end
end
