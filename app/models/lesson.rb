class Lesson < ApplicationRecord
  belongs_to :classroom
  validates :day, presence: true
  belongs_to :schoolroom, optional: true
  belongs_to :laboratory, optional: true
  belongs_to :campus_schedule
end


def acess_campus_schedule(aula)
  @campus_schedules = CampusSchedule.all

  @campus_schedules.each do |horario|

    if (horario.id == aula.campus_schedule_id)
        return horario.start
    end


  end





end
