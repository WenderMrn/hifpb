module SiteHelper
  def format_lesson_info(lesson)
    if lesson.schoolroom and lesson.laboratory
      "#{lesson.classroom.name} <br> #{lesson.schoolroom.name} <br> #{lesson.laboratory.name}".html_safe
    elsif not lesson.schoolroom and lesson.laboratory
      "#{lesson.classroom.name} <br> #{lesson.laboratory.name} <br> #{lesson.classroom.teacher.name}".html_safe
    elsif lesson.schoolroom and not lesson.laboratory
      "#{lesson.classroom.name} <br> #{lesson.schoolroom.name} <br> #{lesson.classroom.teacher.name}".html_safe
    end
  end

  def get_sigla(campus)
    campus.sigla.split("-")[1] || campus.sigla
  end

  def current_campi
    Campus.find(session[:campus_id] || 3)
  end
end
