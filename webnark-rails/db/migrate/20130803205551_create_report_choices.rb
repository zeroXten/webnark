class CreateReportChoices < ActiveRecord::Migration
  def change
    create_table :report_choices do |t|
      t.integer :report_item_id
      t.string :name
      t.boolean :bonus
      t.integer :points
      t.text :help

      t.timestamps
    end
  end
end
