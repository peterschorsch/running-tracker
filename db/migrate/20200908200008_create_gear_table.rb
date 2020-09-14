class CreateGearTable < ActiveRecord::Migration[5.2]
  def change
    create_table :gears do |t|
		t.string :model, :null => false
		t.string :color_way, :null => false
		t.attachment :image, :null => false

		t.integer :forefoot_stack, :null => false, :limit => 2
		t.integer :heel_stack, :null => false, :limit => 2
		t.string :heel_drop, :null => false, :limit => 2
		t.string :weight, :null => false, :limit => 4
		t.string :size, :null => false, :limit => 4
		t.string :shoe_type, :null => false

		t.decimal :mileage, :default => 0

		t.boolean :default, :default => false

		t.date :purchased_on, :null => false
		t.date :first_used_on

		t.boolean :retired, :default => false
		t.date :retired_on

		t.references :shoe_brand, index: true, foreign_key: true

		t.timestamps
    end
  end
end
