class CreateObligationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :obligations do |t|
    	t.string :name, :null => false
    	t.datetime :start_datetime, :null => false
    	t.datetime :end_datetime, :null => false
    	
        t.string :city, :null => false
    	t.references :state, index: true, foreign_key: true

    	t.timestamps
    end
  end
end
