class CreateShoeBrandsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :shoe_brands do |t|
		t.string :brand, :null => false

		t.timestamps
    end
  end
end
