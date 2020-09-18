class CreateWeeklyTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_totals do |t|
      t.string :week_number, :null => false, :limit => 1
      t.string :week_year, :null => false, :limit => 4

      t.decimal :mileage_total, :default => 0, :null => false
      t.decimal :goal, :default => 0, :precision => 5, :scale => 5
      t.boolean :met_goal, :default => false

      t.integer :hours, :null => false
      t.integer :minutes, :null => false, :limit => 3
      t.integer :seconds, :null => false, :limit => 2
      t.integer :number_of_runs, :null => false
      t.integer :elevation_gain, :null => false

      t.text :notes

      #t.references :monthly_total, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
