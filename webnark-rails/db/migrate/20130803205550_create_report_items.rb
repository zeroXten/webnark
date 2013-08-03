class CreateReportItems < ActiveRecord::Migration
  def change
    create_table :report_items do |t|
      t.integer :report_category_id
      t.string :name
      t.text :description
      t.text :help

      t.timestamps
    end
  end
end
