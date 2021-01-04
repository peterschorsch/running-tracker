class CreateRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :runs do |t|
      t.string :name, :null => false
      t.datetime :start_time, :null => false

      t.decimal :planned_mileage, :null => false
      t.decimal :mileage_total, :default => 0
      t.string :pace, :null => false
      t.integer :seconds, :null => false
      t.integer :elevation_gain, :null => false

      t.string :city, :null => false

      t.text :notes

      t.boolean :personal_best, :default => false
      t.boolean :completed_run, :default => false
      t.boolean :active_run, :default => true
      t.boolean :event_flag, :default => false

      t.references :run_type, index: true, foreign_key: true
      t.references :gear, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :monthly_total, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
