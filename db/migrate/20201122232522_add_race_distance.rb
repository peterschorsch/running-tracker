class AddRaceDistance < ActiveRecord::Migration[5.2]
  def change
    create_table :race_distances do |t|
      t.string :name, :null => false
      t.decimal :numeric_distance, :null => false

      t.timestamps
    end
  end
end
