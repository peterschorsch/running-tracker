class AddRaceDistance < ActiveRecord::Migration[5.2]
  def change
    create_table :race_distances do |t|
      t.string :distance, :null => false

      t.timestamps
    end
  end
end
