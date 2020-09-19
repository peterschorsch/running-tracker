class CreateMonthlyTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :monthly_totals do |t|
      t.datetime :month_start, :null => false
      t.datetime :month_end, :null => false

      t.decimal :mileage_total, :null => false
      t.integer :hours, :null => false
      t.integer :minutes, :null => false, :limit => 3
      t.integer :seconds, :null => false, :limit => 2

      t.integer :number_of_runs, :null => false
      t.integer :elevation_gain, :null => false

      t.references :yearly_total, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
