class Admin::ClassroomsController < Admin::AdminController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]

  def index
    authorize Classroom
    if params[:course_id]
      @classrooms = Classroom.where(course_id: params[:course_id]).order(:course_id)
    else
      @classrooms = Classroom.all.order(:course_id)
    end
  end

  def show
    authorize Classroom
  end

  def new
    @classroom = Classroom.new
  end

  def edit
    authorize Classroom
  end

  def create
    authorize Classroom

    @classroom = Classroom.new(classroom_params)

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to admin_classroom_path(@classroom), notice: 'Turma criada com sucesso' }
        format.json { render :show, status: :created, location: @classroom }
      else
        format.html { render :new }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to admin_classroom_path(@classroom), notice: 'Turma criada com sucesso' }
        format.json { render :show, status: :ok, location: @classroom }
      else
        format.html { render :edit }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize Classroom

    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to admin_classrooms_url, notice: 'Turma excluída com sucesso' }
      format.json { head :no_content }
    end
  end

  private
  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

  def classroom_params
    params.require(:classroom).permit(:name, :code, :course_id, :course_subject_id, :teacher_id, :semester_id)
  end
end
