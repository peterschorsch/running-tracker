class CreateAllTimeTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :all_time_totals do |t|
		t.decimal :mileage_total, :null => false
		t.integer :number_of_runs, :null => false
		t.integer :elevation_gain, :null => false

		t.integer :hours, :null => false
		t.integer :minutes, :null => false, :limit => 3
		t.integer :seconds, :null => false, :limit => 2

		t.references :user, index: true, foreign_key: true
    end
  end
end
