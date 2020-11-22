class CreateRaceExamples < ActiveRecord::Migration[5.2]
  def change
    create_table :race_examples do |t|
      t.string :name, :null => false
      t.string :distance, :null => false

      t.string :city, :null => false
      t.references :state, index: true, foreign_key: true

      t.timestamps
    end
  end
end
