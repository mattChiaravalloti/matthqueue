class QuestionsController < ApplicationController
  before_action :set_question, only: [:update, :destroy]

  # POST /questions
  def create
    @course = Course.find(params[:course_id])
    @oh_time_slot = OhTimeSlot.find(params[:oh_time_slot_id])
    @oh_queue = OhQueue.find(params[:oh_queue_id])

    @question = Question.new(
      title: question_params[:title],
      body: question_params[:body],
      oh_queue: @oh_queue,
      position: @oh_queue.next_position,
      student: current_account,
      status: 'unresolved'
    )

    if @question.save
      redirect_to course_oh_time_slot_oh_queue_path(
        @course,@oh_time_slot,@oh_queue
      ), notice: 'Question was successfully created.'
    else
      redirect_to course_oh_time_slot_oh_queue_path(
        @course,@oh_time_slot,@oh_queue
      ), alert: 'Problem creating question!'
    end
  end

  # PATCH/PUT /questions/1
  def update
    @question.status = question_params[:status]
    if @question.status == 'resolved'
      @question.resolve_time = Time.now.utc
      @question.resolver = current_account
    end
    if @question.save
      redirect_to course_oh_time_slot_oh_queue_path(
        @course,@oh_time_slot,@oh_queue
      ), notice: 'Question was successfully updated.'
    else
      redirect_to course_oh_time_slot_oh_queue_path(
        @course,@oh_time_slot,@oh_queue
      ), alert: 'Problem updating question!'
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    redirect_to course_oh_time_slot_oh_queue_path(
      @course,@oh_time_slot,@oh_queue
    ), notice: 'Question was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @course = Course.find(params[:course_id])
      @oh_time_slot = OhTimeSlot.find(params[:oh_time_slot_id])
      @oh_queue = OhQueue.find(params[:oh_queue_id])
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.fetch(:question, {})
    end
end
