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
    @run.user_id = current_user.id
    @run.monthly_total_id = current_user.current_monthly_total.id ### FIX SO THAT MONTHLY TOTAL IS THAT OF START DATE, CREATE NEW MONTHLY TOTAL IF NECESSARY

    set_run_fields

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
    set_run_fields

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
    @run.shoe.subract_mileage_from_shoe(@run.mileage_total)

    ### Update Weekly Total
    @weekly_total = @run.user.current_weekly_total
    if not @weekly_total.nil?
      @run.subtract_from_running_totals(@weekly_total)
    end

    ### Update Monthly Total
    @run.subtract_from_running_totals(current_user.current_monthly_total)

    ### Update Yearly Total
    @run.subtract_from_running_totals(current_user.current_yearly_total)

    ### Update All Time Total
    @run.subtract_from_running_totals(current_user.all_time_total)

    respond_to do |format|
      if @run.make_run_inactive
        format.html { redirect_to calendars_path, notice: "<strong>#{@run.name}</strong> was successfully removed." }
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
      @run = current_user.runs.return_active_runs.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "You are not authorized to view specified run."
      redirect_to runs_path
    end

    # Only allow a list of trusted parameters through.
    def run_params
      params.require(:run).permit(:name, :completed_run, :planned_mileage, :mileage_total, :start_time, :pace_minutes, :pace_seconds, :hours, :minutes, :seconds, :elevation_gain, :city, :notes, :personal_best, :shoe_id, :state_id, :run_type_id)
    end

    def set_run_fields
      @run.set_necessary_run_fields(params[:run][:hours], params[:run][:minutes], params[:run][:seconds])
    end
end
