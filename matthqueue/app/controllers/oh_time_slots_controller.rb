class OhTimeSlotsController < ApplicationController
  before_action :set_oh_time_slot, only: [:show, :edit, :update, :destroy]

  # GET /oh_time_slots/1
  def show
  end

  # GET /oh_time_slots/1/edit
  def edit
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

  # PATCH/PUT /oh_time_slots/1
  # PATCH/PUT /oh_time_slots/1.json
  def update
    if @oh_time_slot.update(oh_time_slot_params)
      redirect_to @oh_time_slot, notice: 'Oh time slot was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /oh_time_slots/1
  def destroy
    @oh_time_slot.destroy
    redirect_to oh_time_slots_url, notice: 'Oh time slot was successfully destroyed.'
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
