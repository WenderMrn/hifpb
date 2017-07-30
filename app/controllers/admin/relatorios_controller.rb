class Admin::RelatoriosController < Admin::AdminController
  def index

  end

  def professores
    @teachers = Teacher.all
  end

  def salas
    @schoolrooms = Schoolroom.all
  end

  def laboratorios
    @laboratories = Laboratory.all
  end

  def professor
    @teacher = Teacher.find(params[:id])
    @monday = Lesson.where(teacher: @teacher, day: 'Segunda')
    @tuesday = Lesson.where(teacher: @teacher, day: 'Terça')
    @wednesday = Lesson.where(teacher: @teacher, day: 'Quarta')
    @thursday = Lesson.where(teacher: @teacher, day: 'Quinta')
    @friday = Lesson.where(teacher: @teacher, day: 'Sexta')
    # @campus_schedules = CampusSchedule.where(campus: @classroom.course.campus)
  end

  def sala
    @classroom = Classroom.find(params[:id])
    @monday = Lesson.where(classroom: @classroom, day: 'Segunda')
    @tuesday = Lesson.where(classroom: @classroom, day: 'Terça')
    @wednesday = Lesson.where(classroom: @classroom, day: 'Quarta')
    @thursday = Lesson.where(classroom: @classroom, day: 'Quinta')
    @friday = Lesson.where(classroom: @classroom, day: 'Sexta')
  end

  def laboratorio
    @laboratory = Laboratory.find(params[:id])
    @monday = Lesson.where(laboratory: @laboratory, day: 'Segunda')
    @tuesday = Lesson.where(laboratory: @laboratory, day: 'Terça')
    @wednesday = Lesson.where(laboratory: @laboratory, day: 'Quarta')
    @thursday = Lesson.where(laboratory: @laboratory, day: 'Quinta')
    @friday = Lesson.where(laboratory: @laboratory, day: 'Sexta')
  end

end
