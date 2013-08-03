class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :service_id
      t.integer :report_choice_id
      t.text :notes

      t.timestamps
    end
  end
end
