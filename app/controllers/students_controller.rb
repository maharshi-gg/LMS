class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # GET /students
  # GET /students.json
  def index
    @students = Student.all
    authorize Student
  end

  # GET /students/1
  # GET /students/1.json
  def show
    authorize Student
  end

  # GET /students/new
  def new
    @student = Student.new
    authorize Student
  end

  # GET /students/1/edit
  def edit
    authorize Student
  end

  # POST /students
  # POST /students.json
  def create
    authorize Student
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    authorize Student
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    authorize Student
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def find_student_id(email)
    return Student.find_by_email(email)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:email, :name, :password, :education, :university, :max_books)
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
end
