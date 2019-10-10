class Library < ApplicationRecord
  # has_many :librarians
  validates :name, :university, :location, :max_days, :fines, presence: true
end
