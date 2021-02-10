class CreateMonthlyTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :monthly_totals do |t|
      t.date :month_start, :null => false
      t.date :month_end, :null => false

      t.decimal :previous_mileage, :default => 0
      t.decimal :new_mileage, :default => 0
      t.decimal :mileage_total, :default => 0

      t.integer :previous_number_of_runs, :default => 0
      t.integer :new_number_of_runs, :default => 0
      t.integer :number_of_runs, :default => 0

      t.integer :previous_elevation_gain, :default => 0
      t.integer :new_elevation_gain, :default => 0
      t.integer :elevation_gain, :default => 0

      t.integer :previous_time_in_seconds, :default => 0
      t.integer :new_time_in_seconds, :default => 0
      t.integer :time_in_seconds, :default => 0

      t.boolean :frozen_flag, :default => false

      t.references :yearly_total, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
