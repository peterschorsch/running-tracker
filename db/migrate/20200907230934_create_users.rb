class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false

      t.string :default_city, :null => false
      t.string :default_state, :null => false
      t.string :default_country, :null => false
      t.string :time_zone, default: "UTC"

      t.boolean :active, :default => true
      t.datetime :last_login

      t.string :users, :password_digest

      t.references :user_role, index: true, foreign_key: true

      t.timestamps
    end
  end
end
