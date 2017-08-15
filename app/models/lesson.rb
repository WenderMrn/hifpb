class Lesson < ApplicationRecord
  belongs_to :classroom
  validates :day, presence: true
  belongs_to :schoolroom, optional: true
  belongs_to :laboratory, optional: true
  belongs_to :campus_schedule
  validates :day, uniqueness: { scope: [:campus_schedule, :classroom], message: "A turma já possui aula neste horário" }
  validates :day, uniqueness: { scope: [:campus_schedule, :schoolroom], message: "Esta sala já está reservada neste horário" }
  validates :day, uniqueness: { scope: [:campus_schedule, :laboratory], message: "Este laboratório já está reservado neste horário" }
  validate :there_must_be_one_of_the_two

  def there_must_be_one_of_the_two
    if (schoolroom == nil) && (laboratory == nil)
      errors.add(:Aula, "deve haver um laboratório ou uma sala")
    end
  end

  def to_s
    if schoolroom and laboratory
      "#{classroom.name} - #{schoolroom.name} - #{campus_schedule.to_s} - #{laboratory.name}"
    elsif not schoolroom and laboratory
      "#{classroom.name} - #{campus_schedule.to_s} - #{laboratory.name}"
    elsif schoolroom and not laboratory
      "#{classroom.name} - #{schoolroom.name} - #{campus_schedule.to_s}"
    end
  end

  scope :by_semester, -> (semester) {
    joins(:classroom).joins(classroom: :course_subject).where(classrooms: {course_subjects: {semester: semester}}).order(day: :asc)
  }
end
