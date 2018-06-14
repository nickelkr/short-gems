class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.user :references
      t.string :type
      t.boolean :active

      t.timestamps
    end
  end
end
