class OhQueuesController < ApplicationController
  before_action :set_oh_queue, only: [:show, :edit, :update, :destroy]

  # GET /oh_queues
  # GET /oh_queues.json
  def index
    @oh_queues = OhQueue.all
  end

  # GET /oh_queues/1
  # GET /oh_queues/1.json
  def show
  end

  # GET /oh_queues/new
  def new
    @oh_queue = OhQueue.new
  end

  # GET /oh_queues/1/edit
  def edit
  end

  # POST /oh_queues
  # POST /oh_queues.json
  def create
    @oh_queue = OhQueue.new(oh_queue_params)

    respond_to do |format|
      if @oh_queue.save
        format.html { redirect_to @oh_queue, notice: 'Oh queue was successfully created.' }
        format.json { render :show, status: :created, location: @oh_queue }
      else
        format.html { render :new }
        format.json { render json: @oh_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /oh_queues/1
  # PATCH/PUT /oh_queues/1.json
  def update
    respond_to do |format|
      if @oh_queue.update(oh_queue_params)
        format.html { redirect_to @oh_queue, notice: 'Oh queue was successfully updated.' }
        format.json { render :show, status: :ok, location: @oh_queue }
      else
        format.html { render :edit }
        format.json { render json: @oh_queue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oh_queues/1
  # DELETE /oh_queues/1.json
  def destroy
    @oh_queue.destroy
    respond_to do |format|
      format.html { redirect_to oh_queues_url, notice: 'Oh queue was successfully destroyed.' }
      format.json { head :no_content }
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
