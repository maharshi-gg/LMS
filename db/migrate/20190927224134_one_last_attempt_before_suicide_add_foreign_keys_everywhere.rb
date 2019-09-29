class OneLastAttemptBeforeSuicideAddForeignKeysEverywhere < ActiveRecord::Migration[5.2]
  def change
    add_column :book_request, :student_id, foreign_key: true
    add_column :book_request, :book_id, foreign_key: true

    add_reference :book_request, :student_id, references: :students, index: true
    add_reference :book_request, :book_id, references: :books, index: true

  end
end
