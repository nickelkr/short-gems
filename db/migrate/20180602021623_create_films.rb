class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :external_id
      t.string :title
      t.integer :runtime

      t.timestamps
    end
  end
end
