class Admin::LessonsController < Admin::AdminController
  before_action :set_lesson, only: [:edit, :update, :destroy]

  def index
    @classroom = Classroom.find(params[:classroom_id])
    @monday = Lesson.where(classroom: @classroom, day: 'Segunda')
    @tuesday = Lesson.where(classroom: @classroom, day: 'Terça')
    @wednesday = Lesson.where(classroom: @classroom, day: 'Quarta')
    @thursday = Lesson.where(classroom: @classroom, day: 'Quinta')
    @friday = Lesson.where(classroom: @classroom, day: 'Sexta')
    @campus_schedules = CampusSchedule.where(campus: @classroom.course.campus)
  end

  def new
    @classroom = Classroom.find(params[:classroom_id])
    @lesson = Lesson.new(classroom: @classroom)
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @classroom = Classroom.find(params[:classroom_id])
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to admin_classroom_lessons_path, notice: 'Aula criada com sucesso.' }
      else
        format.html { flash[:danger] = @lesson.errors.full_messages.to_sentence
         render :new }
       end
     end
   end

  def update
    respond_to do |format|
      if @lesson.update(lesson_params)       
        format.html { redirect_to admin_classroom_lessons_path, notice: 'Aula atualizada com sucesso' }
      else
        format.html {  flash[:danger] = @lesson.errors.full_messages.to_sentence
         render :edit }
       end
     end
   end

  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to admin_classroom_lessons_path, notice: 'Aula excluida com sucesso' }
      format.json { head :no_content }
    end
  end

  private
  def set_lesson
    @lesson = Lesson.find(params[:id])
    @classroom = Classroom.find(params[:classroom_id])
  end

  def lesson_params
    params.require(:lesson).permit(:classroom_id,:day,:schoolroom_id,:laboratory_id,:campus_schedule_id)
  end
end
