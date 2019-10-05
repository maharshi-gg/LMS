class BookRequest < ApplicationRecord
  self.table_name='book_request'
  belongs_to :books_id
  belongs_to :librarians_id
  belongs_to :students_id
end
