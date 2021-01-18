class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
    	t.string :name, :null => false
      t.string :abbreviation, :null => false, limit: 2

      t.timestamps
    end

    add_reference :runs, :country, index: true
  end
end
