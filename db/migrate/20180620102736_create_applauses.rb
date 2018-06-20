class CreateApplauses < ActiveRecord::Migration[5.2]
  def change
    create_table :applauses do |t|
      t.integer :category
      t.references :film, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
