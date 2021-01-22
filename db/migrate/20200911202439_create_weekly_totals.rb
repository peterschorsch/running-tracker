class CreateWeeklyTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :weekly_totals do |t|
      t.date :week_start, :null => false
      t.date :week_end, :null => false

      t.decimal :mileage_total, :default => 0, :null => false
      t.decimal :mileage_goal, :default => 0, :precision => 5, :scale => 5
      t.boolean :met_goal, :default => false

      t.integer :time_in_seconds, :null => false
      t.integer :number_of_runs, :null => false
      t.integer :elevation_gain, :null => false

      t.boolean :frozen_flag, :default => false

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
