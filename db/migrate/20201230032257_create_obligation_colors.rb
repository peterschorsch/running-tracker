class CreateObligationColors < ActiveRecord::Migration[5.2]
  def change
    create_table :obligation_colors do |t|
    	t.string :name, :null => false
    	t.string :hex_code, :null => false, :limit => 7

    	t.timestamps
    end
  end
end
