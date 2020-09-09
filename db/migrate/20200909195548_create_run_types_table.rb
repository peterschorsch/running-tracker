class CreateRunTypesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :run_types do |t|
    	t.string :name, :null => false
    	t.string :hex_code, :null => false, :limit => 7
    	
    	t.boolean :active, :default => true
    	t.boolean :default, :default => false

    	t.timestamps
    end
  end
end
