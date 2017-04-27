class OhTimeSlotsController < ApplicationController
  before_action :set_oh_time_slot, only: [:show, :launch_queue]

  # GET /oh_time_slots/1
  def show
    @course = Course.find(params[:course_id])
  end

  # POST /oh_time_slots
  def create
    @course = Course.find(params[:course_id])
    start_time = DateTime.parse(oh_time_slot_params[:start_time].first).to_time - Time.zone_offset(oh_time_slot_params[:timezone])

    @oh_time_slot = OhTimeSlot.new(
      frequency: oh_time_slot_params[:frequency],
      start_time: start_time,
      end_time: start_time + oh_time_slot_params[:duration].to_i.hours,
      course: @course
    )

    if @oh_time_slot.save
      redirect_to @course, notice: 'OH Timeslot was successfully created.'
    else
      redirect_to @course, alert: 'Problem creating office hours!'
    end
  end

  def launch_queue
    @queue = OhQueue.create(
      active: true, # active upon creation
      last_postition: 1, # first question in the queue is "question 1",
      start_time: Time.now.utc,
      oh_time_slot: @oh_time_slot
    )

    if @queue.save
      redirect_to @queue, notice: 'Queue successfully launched.'
    else
      redirect_to @oh_time_slot, alert: 'Failed to launch queue!'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oh_time_slot
      @oh_time_slot = OhTimeSlot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oh_time_slot_params
      params.fetch(:oh_time_slot, {})
    end
end
