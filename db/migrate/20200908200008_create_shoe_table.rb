class CreateShoeTable < ActiveRecord::Migration[5.2]
  def change
    create_table :shoes do |t|
		t.string :model, :null => false
		t.string :color_way, :null => false
		t.attachment :image, :null => false

		t.decimal :forefoot_stack, :default => "0.0", :limit => 4, :null => false
		t.decimal :heel_stack, :default => "0.0", :limit => 4
		t.string :heel_drop, :default => "0", :limit => 4
		t.string :weight, :default => "0", :limit => 4
		t.string :size, :default => "0", :limit => 4
		t.string :shoe_type, :null => false

		t.decimal :previous_mileage, :default => 0
		t.decimal :new_mileage, :default => 0
		t.decimal :mileage_total, :default => 0

		t.boolean :default, :default => false

		t.date :purchased_on, :null => false
		t.date :first_used_on

		t.boolean :retired, :default => false
		t.date :retired_on

		t.references :user, index: true, foreign_key: true
		t.references :shoe_brand, index: true, foreign_key: true

		t.timestamps
    end
  end
end
