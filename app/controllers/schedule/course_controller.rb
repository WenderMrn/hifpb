class Schedule::CourseController < SiteController

  def index
    @courses = Course.where(campus: get_campi)
    @selected_campus = Campus.find(get_campi)
  end

  def show
    if params[:course] and params[:semester]
      @course = Course.find_by(id: params[:course])
      @semester = params[:semester]
      @lessons = Lesson.by_semester(params[:semester]).by_course(params[:course])
      @schedules = CampusSchedule.where(campus: Schoolroom.first.campus).order(:shift)
      @semesters = CourseSubject.semester_by_course(params[:course])
    end
  end
end
