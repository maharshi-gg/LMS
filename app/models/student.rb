class Student < ApplicationRecord
  validates :email, :name, :education, :university, :max_books, presence: true
end
