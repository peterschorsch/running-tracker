class CreateObligationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :obligations do |t|
    	t.string :name, :null => false
        t.datetime :start_time, :null => false
        t.datetime :end_time
    	
        t.string :city, :null => false

        t.boolean :event_flag, :default => true

    	t.references :state, index: true, foreign_key: true
        t.references :country, index: true, foreign_key: true
        t.references :user, index: true, foreign_key: true
        t.references :obligation_color, index: true, foreign_key: true

    	t.timestamps
    end
  end
end
