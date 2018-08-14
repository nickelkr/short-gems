class AddSourceToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :source, :integer
  end
end
