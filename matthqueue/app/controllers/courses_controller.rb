class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :add_instructor, :add_oh_time_slot,
                                    :destroy]

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
      redirect_to @account, alert: 'Course was not created!'
    end
  end

  # POST /enroll_course
  def enroll
    @course = Course.where(:name=>course_params[:name])
                    .where(:semester=>course_params[:semester])
                    .where(:institution_id=>course_params[:institution_id])
                    .first
    @account = Account.find(params[:student_id])
    @account.enrolled_courses << @course

    if @course.save && @account.save
      redirect_to @course, notice: "#{@account.name} successfully enrolled."
    else
      redirect_to @account, alert: 'Problem with enrollment!'
    end
  end

  # POST /drop_course
  def drop
    @course = Course.find(params[:course_id])
    @account = Account.find(params[:student_id])

    @account.enrolled_courses.delete(@course)

    redirect_to @account, notice: "Successfully dropped #{@course.name}."
  end

  # POST /courses/1/add_instructor
  def add_instructor
    @account = Account.find_by(:email=>params[:instructor_email])
    @account.instructed_courses << @course

    redirect_to @course,
                notice: "Successfully added #{@account.name} as instructor."
  rescue
    redirect_to @course,
                alert: "Unable to add instructor!"
  end

  # POST /courses/1/add_oh_time_slot
  def add_oh_time_slot
    params = oh_time_slot_params

    # end time = start time + (duration (in hours) * 3600 (seconds))
    params[:end_time] = params[:start_time] + (params[:duration] * 3600)
    params[:course] = @course
    
    @oh_time_slot = OhTimeSlot.create(params)

    if @oh_time_slot.save
      redirect_to @course, notice: 'Office Hours Timeslot successfully created.'
    else
      redirect_to @course, alert: 'Unable to create timeslot!'
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

    def oh_time_slot_params
      params.require(:oh_time_slot).permit(:start_time, :duration, :frequency)
    end
end
