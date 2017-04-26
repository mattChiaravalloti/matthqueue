class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :destroy]

  # GET /courses/1
  def show
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    @account = Account.find(params[:instructor_id])
    @account.instructed_courses << @course

    if @course.save && @account.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      redirect_to @account, notice: 'Course was not created!'
    end
  end

  # DELETE /courses/1
  def destroy
    @course.destroy
    redirect_to current_account, notice: 'Course was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :institution_id, :semester)
    end
end
