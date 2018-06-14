class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.belongs_to :user
      t.string :role_type
      t.boolean :active

      t.timestamps
    end
  end
end
