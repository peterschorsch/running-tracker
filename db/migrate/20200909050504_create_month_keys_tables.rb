class CreateMonthKeysTables < ActiveRecord::Migration[5.2]
  def change
    create_table :month_keys do |t|
    	t.integer :number, :null => false, limit: 1
		t.string :name, :null => false

		t.timestamps
    end
  end
end
