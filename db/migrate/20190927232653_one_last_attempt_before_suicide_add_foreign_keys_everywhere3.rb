class OneLastAttemptBeforeSuicideAddForeignKeysEverywhere3 < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_request, :student_id_id
    remove_column :book_request, :book_id_id

    add_reference :book_request, :students, foreign_key: true
  end
end
