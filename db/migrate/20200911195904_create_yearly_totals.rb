class CreateYearlyTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :yearly_totals do |t|
      t.string :year, :null => false, :limit => 4
      t.date :year_start, :null => false
      t.date :year_end, :null => false

      t.decimal :mileage_total, :null => false
      t.integer :number_of_runs, :null => false
      t.integer :elevation_gain, :null => false
      t.integer :time_in_seconds, :null => false

      t.boolean :frozen_flag, :default => false

      t.references :all_time_total, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
