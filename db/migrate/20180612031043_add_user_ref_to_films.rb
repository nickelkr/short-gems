class AddUserRefToFilms < ActiveRecord::Migration[5.2]
  def change
    add_reference :films, :user, foreign_key: true
  end
end
