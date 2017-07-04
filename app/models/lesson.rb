class Lesson < ApplicationRecord
  validates :day, presence: true
  belongs_to :laboratory
  belongs_to :schoolroom
  belongs_to :classroom
  belongs_to :campus_schedules
end
