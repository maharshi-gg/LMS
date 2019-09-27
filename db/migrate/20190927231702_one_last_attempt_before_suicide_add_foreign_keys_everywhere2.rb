class OneLastAttemptBeforeSuicideAddForeignKeysEverywhere2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_request, "{:references=>:students, :index=>true}_id"
    remove_column :book_request, "{:references=>:books, :index=>true}_id"

    # add_column :book_request, :student_id, type:references
    # add_column :book_request, :book_id, type:

    add_reference :book_request, :student_id, references: :students, index: true
    add_reference :book_request, :book_id, references: :books, index: true

  end
end
