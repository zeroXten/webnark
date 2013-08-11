class AddScoreAndScoreUpdatedAtToServices < ActiveRecord::Migration
  def change
    add_column :services, :score, :float
    add_column :services, :score_updated_at, :datetime
  end
end
