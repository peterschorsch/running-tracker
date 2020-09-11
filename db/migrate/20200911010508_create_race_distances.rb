class CreateRaceDistances < ActiveRecord::Migration[5.2]
  def change
    create_table :race_distances do |t|
      t.string :name, :null => false
      t.decimal :distance_miles, :null => false, :precision => 5, :scale => 5

      t.timestamps
    end
  end
end
