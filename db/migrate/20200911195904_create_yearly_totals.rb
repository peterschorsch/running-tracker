class CreateYearlyTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :yearly_totals do |t|
      t.string :year, :null => false, :limit => 4

      t.decimal :mileage_total, :null => false
      t.integer :number_of_runs, :null => false
      t.integer :elevation_gain, :null => false

      t.integer :hours, :null => false
      t.integer :minutes, :null => false, :limit => 3
      t.integer :seconds, :null => false, :limit => 2

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
