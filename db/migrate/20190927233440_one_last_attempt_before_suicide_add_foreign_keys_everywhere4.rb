class OneLastAttemptBeforeSuicideAddForeignKeysEverywhere4 < ActiveRecord::Migration[5.2]
  def change
    add_reference :book_request, :books, foreign_key: true
    add_reference :book_request, :librarians, foreign_key: true
    add_reference :books, :students, foreign_key: true
  end
end
