class CreateRaceExample < ActiveRecord::Migration[5.2]
  def change
    create_table :race_examples do |t|
      t.string :name, :null => false

      t.string :hours
      t.string :minutes, :null => false
      t.string :seconds, :null => false
      t.string :pace, :null => false
      t.string :elevation_gain, :null => false

      t.string :city, :null => false

      t.references :state, index: true, foreign_key: true
      t.references :race_distance, index: true, foreign_key: true

      t.timestamps
    end
  end
end
