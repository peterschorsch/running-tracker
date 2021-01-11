class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.string :time_zone, default: "UTC"

      t.boolean :active, :default => true

      t.string :users, :password_digest

      t.references :user_role, index: true, foreign_key: true

      t.timestamps
    end
  end
end
