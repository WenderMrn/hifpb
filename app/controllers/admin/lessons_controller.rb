class Admin::LessonsController < Admin::AdminController
before_action :set_lesson, only: [:edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @classroom = Classroom.find(params[:classroom_id])
    @lessons = Lesson.where(classroom: @classroom)
    @campus_schedules = CampusSchedule.all

  end



  # GET /lessons/new
  def new
    @classroom = Classroom.find(params[:classroom_id])
    @lesson = Lesson.new(classroom: @classroom)

  end

  # GET /lessons/1/edit
  def edit

    @lesson = Lesson.find(params[:id])
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)
    @classroom = Classroom.find(params[:classroom_id])

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to admin_classroom_lessons_path, notice: 'Aula criada com sucesso.' }

      else
        puts @lesson.errors.inspect

        format.html {  flash[:danger] = @lesson.errors.full_messages.to_sentence
           render :new }

      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
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

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to admin_classroom_lessons_path, notice: 'Aula excluida com sucesso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
      @classroom = Classroom.find(params[:classroom_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:classroom_id,:day,:schoolroom_id,:laboratory_id,:campus_schedule_id)
    end
end
