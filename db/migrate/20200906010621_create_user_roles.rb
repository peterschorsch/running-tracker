class CreateUserRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_roles do |t|
      t.string :name, :null => false

      t.boolean :administrator, :default => false
      t.boolean :user, :default => false
      t.boolean :website_viewer, :default => false

      t.timestamps
    end
  end
end
