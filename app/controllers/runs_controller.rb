class RunsController < ApplicationController
  before_action :set_run, only: [:edit, :update, :destroy]

  # GET /runs
  # GET /runs.json
  def index
    @runs = current_user.runs.return_completed_runs.includes(:run_type, gear: :shoe_brand).order_by_most_recent
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

    @run.gear.add_mileage_to_shoe(@run.mileage_total)

    respond_to do |format|
      if @run.save
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
    @run.user_id = current_user.id
    @run.gear.update_mileage_of_shoe(params[:run][:mileage_total].to_f)

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
    @run.gear.subract_mileage_to_shoe(@run.mileage_total)

    ### Update Weekly Total
    @weekly_total = @run.user.weekly_totals.find_by(week_start: @run.start_time.beginning_of_week.beginning_of_day)
    if not @weekly_total.nil?
      @run.subtract_from_running_totals(@weekly_total)
      @weekly_total.update_met_goal_field
    end

    ### Update Monthly Total
    @run.subtract_from_running_totals(current_user.monthly_totals.of_month)

    ### Update Yearly Total
    @run.subtract_from_running_totals(current_user.yearly_totals.of_current_year)

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
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      @run = Run.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def run_params
      params.require(:run).permit(:name, :completed_run, :planned_mileage, :mileage_total, :start_time, :hours, :minutes, :seconds, :pace, :elevation_gain, :city, :notes, :personal_best, :gear_id, :state_id, :run_type_id)
    end
end
