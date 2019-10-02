class RemoveFKfromLibrarians < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :librarians, column: "users_id"
    remove_foreign_key :librarians, column: "libraries_id"
  end
end
