class CreateReportCategories < ActiveRecord::Migration
  def change
    create_table :report_categories do |t|
      t.string :name
      t.text :description
      t.string :icon_url

      t.timestamps
    end
  end
end
