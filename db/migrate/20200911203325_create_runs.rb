class CreateRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :runs do |t|
      t.string :name, :null => false
      t.datetime :start_time, :null => false

      t.decimal :distance, :null => false, :precision => 5, :scale => 5
      t.string :pace, :null => false
      t.integer :hours
      t.integer :minutes, :null => false, :limit => 3
      t.integer :seconds, :null => false, :limit => 2

      t.integer :elevation_gain, :null => false
      t.string :avg_heart_rate, :null => false, :limit => 3
      t.string :max_heart_rate, :null => false, :limit => 3

      t.string :city, :null => false

      t.text :notes

      t.boolean :personal_best, :default => false

      t.references :run_type, index: true, foreign_key: true
      t.references :gear, index: true, foreign_key: true
      t.references :state, index: true, foreign_key: true
      t.references :weekly_total, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
