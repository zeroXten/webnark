class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :slug
      t.string :hosting_provider
      t.string :country
      t.string :screenshot_url

      t.timestamps
    end
  end
end
