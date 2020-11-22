class AddRaceDistance < ActiveRecord::Migration[5.2]
  def change
  	create_table :race_distance do |t|
      t.string :distance, :null => false

      t.references :race_example, index: true, foreign_key: true

      t.timestamps
    end
  end
end
