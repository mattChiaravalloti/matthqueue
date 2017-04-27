class OhQueuesController < ApplicationController
  before_action :set_oh_queue, only: [:show, :end_queue]

  # GET /oh_queues/1
  def show
  end

  def end_queue
    @course = Course.find(params[:couse_id])

    if @course.instructors.include? current_account
      @oh_queue.active = false
      if @oh_queue.save
        redirect_to @oh_queue, notice: 'Queue has been closed.'
      else
        redirect_to @oh_queue, alert: 'Problem closing queue!'
      end
    else
      redirect_to @oh_queue, alert: 'Only instructors can close the queue!'
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
