  class Lesson < ApplicationRecord
    belongs_to :classroom
    validates :day, presence: true
    belongs_to :schoolroom, optional: true
    belongs_to :laboratory, optional: true
    belongs_to :campus_schedule
    validate :there_must_be_one_of_the_two
    validate :can_not_lesson_schedule_twice
    validate :can_not_teach_a_lesson_twice


    def there_must_be_one_of_the_two
        if (schoolroom == nil) && (laboratory == nil)
          errors.add(:Aula, "deve haver um laboratório ou uma sala")
        end
    end

    def can_not_lesson_schedule_twice
      @classroom = Classroom.find(classroom_id)
      @lessons = Lesson.where(classroom: @classroom)

        @lessons.each{ |l|
          if (l.day.include? day) && (l.campus_schedule_id == campus_schedule_id)
            errors.add(:Falha,", já existe um horário reservado para este dia")
          end
        }
    end
    def can_not_teach_a_lesson_twice
      @classroom = Classroom.find(classroom_id)
      @teacher = @classroom.teacher_id
      @lessons = Lesson.all

        @lessons.each{ |l|
          if (l.classroom.teacher_id == @teacher)
            if (l.day.include? day) && (l.campus_schedule_id == campus_schedule_id)
              errors.add(:Falha,", já existe um horário reservado do professor para este dia")
            end

          end
        }
    end
  end
