class RunsController < ApplicationController
  before_action :set_run, only: [:edit, :update, :destroy]

  # GET /runs
  # GET /runs.json
  def index
    @runs = Run.of_user(current_user).includes(gear: :shoe_brand).order_by_most_recent
  end

  # GET /runs/new
  def new
    @run = Run.new
  end

  # GET /runs/1/edit
  def edit
  end

  # POST /runs
  # POST /runs.json
  def create
    @run = Run.new(run_params)
    @run.user_id = current_user.id

    respond_to do |format|
      if @run.save
        format.html { redirect_to runs_path, notice: "<strong>#{@run.name}</strong> was successfully created." }
        format.json { render :index, status: :created, location: @run }
      else
        format.html { render :new }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /runs/1
  # PATCH/PUT /runs/1.json
  def update
    @run.user_id = current_user.id

    respond_to do |format|
      if @run.update(run_params)
        format.html { redirect_to runs_path, notice: "<strong>#{@run.name}</strong> was successfully updated." }
        format.json { render :index, status: :ok, location: @run }
      else
        format.html { render :edit }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runs/1
  # DELETE /runs/1.json
  def destroy
    @run.destroy
    respond_to do |format|
      format.html { redirect_to runs_path, notice: "<strong>#{@run.name}</strong> was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def run_params
      params.require(:run).permit(:name, :mileage, :start_time, :hours, :minutes, :seconds, :pace, :elevation_gain, :city, :notes, :personal_best, :gear_id, :state_id)
    end
end
