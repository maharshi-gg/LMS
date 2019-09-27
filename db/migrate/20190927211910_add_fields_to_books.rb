class AddFieldsToBooks < ActiveRecord::Migration[5.2]
  def change
    # creating table BookRequest.
    create_table :book_request do |t|
      t.date :date
      t.boolean :is_special
      t.boolean :is_approved
    end

    add_reference :librarians, foreign_key: {to_table: :book_request}
    add_reference :students, foreign_key: {to_table: :book_request}
    add_reference :books, foreign_key: {to_table: :book_request}

    # adding fields to Books table.
    add_column :books, :book_count, :integer
    add_column :books, :is_issued, :boolean
    add_column :books, :number_hold_req, :integer




    # add_foreign_key :books, :book_request
    # add_foreign_key :students, :book_request
    # add_foreign_key :librarians, :book_request

  end
end
