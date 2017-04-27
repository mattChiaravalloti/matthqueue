class OhQueuesController < ApplicationController
  before_action :set_oh_queue, only: [:show, :end_queue]

  # GET /oh_queues/1
  def show
    @course = Course.find(params[:course_id])
    @oh_time_slot = OhTimeSlot.find(params[:oh_time_slot_id])
  end

  def end_queue
    if @oh_queue.active
      @course = Course.find(params[:course_id])
      @oh_time_slot = OhTimeSlot.find(params[:oh_time_slot_id])

      if @course.instructors.include? current_account
        @oh_queue.active = false
        @oh_queue.end_time = Time.now.utc
        if @oh_queue.save
          redirect_to course_oh_time_slot_oh_queue_path(
            @course,@oh_time_slot,@oh_queue), notice: 'Queue has been closed.'
        else
          redirect_to course_oh_time_slot_oh_queue_path(
            @course,@oh_time_slot,@oh_queue), alert: 'Problem closing queue!'
        end
      else
        redirect_to course_oh_time_slot_oh_queue_path(
          @course,@oh_time_slot,@oh_queue
        ), alert: 'Only instructors can close a queue!'
      end
    else
      redirect_to course_oh_time_slot_oh_queue_path(
        @course,@oh_time_slot,@oh_queue), notice: 'Queue already closed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oh_queue
      @oh_queue = OhQueue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oh_queue_params
      params.fetch(:oh_queue, {})
    end
end
