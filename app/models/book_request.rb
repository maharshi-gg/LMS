class BookRequest < ApplicationRecord
  belongs_to :books_id
  belongs_to :librarians_id
  belongs_to :students_id
end
