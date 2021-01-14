class RunsController < ApplicationController
  before_action :set_run, only: [:edit, :update, :destroy]
  before_action :viewer_authorization, only: [:create, :update, :destroy]

  # GET /runs
  # GET /runs.json
  def index
    @runs = current_user.return_completed_runs.includes(:run_type, shoe: :shoe_brand).order_by_most_recent
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

    ### Also, converts and sets hours, minutes, seconds to just seconds ###
    @run.set_necessary_run_fields(current_user, params[:run][:hours], params[:run][:minutes], params[:run][:seconds])

    respond_to do |format|
      if @run.save
        @run.update_subsequent_tables

        format.html { redirect_to runs_path, notice: "<strong>#{@run.name}</strong> was successfully created." }
        format.json { render :new, status: :created, location: @run }
      else
        format.html { render :new }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /runs/1
  # PATCH/PUT /runs/1.json
  def update
    ### Also, converts and sets hours, minutes, seconds to just seconds ###
    @run.set_necessary_run_fields(current_user, params[:run][:hours], params[:run][:minutes], params[:run][:seconds])

    respond_to do |format|
      if @run.update(run_params)
        @run.update_subsequent_tables

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
    respond_to do |format|
      if @run.destroy
        format.html { redirect_to runs_path, notice: "<strong>#{@run.name}</strong> was successfully removed." }
        format.json { render :index, status: :ok, location: @run }
      else
        format.html { render :index }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def viewer_authorization
      if current_user.is_viewer?
        flash[:alert] = "You are not authorized to do said action."
        redirect_to runs_path
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = current_user.runs.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "You are not authorized to view specified run."
      redirect_to runs_path
    end

    # Only allow a list of trusted parameters through.
    def run_params
      params.require(:run).permit(:name, :completed_run, :planned_mileage, :mileage_total, :start_time, :pace_minutes, :pace_seconds, :hours, :minutes, :seconds, :elevation_gain, :city, :notes, :personal_best, :shoe_id, :state_id, :run_type_id)
    end

end
