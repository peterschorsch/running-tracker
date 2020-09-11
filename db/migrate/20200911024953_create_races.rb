class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.string :race, :null => false
      t.datetime :race_datetime, :null => false
      t.string :hours, :null => false, :limit => 3
      t.string :minutes, :null => false, :limit => 2
      t.string :seconds, :null => false, :limit => 2
      t.string :pace, :null => false
      t.text :notes
      t.string :city, :null => false
      t.string :bib_number, :null => false

      t.references :gear, index: true, foreign_key: true
      t.references :race_distance, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true

      t.timestamps
    end
  end
end
