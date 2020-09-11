class WeeklyTotalsController < ApplicationController
  before_action :set_weekly_total, only: [:show, :edit, :update, :destroy]

  # GET /weekly_totals
  # GET /weekly_totals.json
  def index
    @weekly_totals = WeeklyTotal.all
  end

  # GET /weekly_totals/1
  # GET /weekly_totals/1.json
  def show
  end

  # GET /weekly_totals/new
  def new
    @weekly_total = WeeklyTotal.new
  end

  # GET /weekly_totals/1/edit
  def edit
  end

  # POST /weekly_totals
  # POST /weekly_totals.json
  def create
    @weekly_total = WeeklyTotal.new(weekly_total_params)

    respond_to do |format|
      if @weekly_total.save
        format.html { redirect_to @weekly_total, notice: 'Weekly total was successfully created.' }
        format.json { render :show, status: :created, location: @weekly_total }
      else
        format.html { render :new }
        format.json { render json: @weekly_total.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekly_totals/1
  # PATCH/PUT /weekly_totals/1.json
  def update
    respond_to do |format|
      if @weekly_total.update(weekly_total_params)
        format.html { redirect_to @weekly_total, notice: 'Weekly total was successfully updated.' }
        format.json { render :show, status: :ok, location: @weekly_total }
      else
        format.html { render :edit }
        format.json { render json: @weekly_total.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_totals/1
  # DELETE /weekly_totals/1.json
  def destroy
    @weekly_total.destroy
    respond_to do |format|
      format.html { redirect_to weekly_totals_url, notice: 'Weekly total was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_total
      @weekly_total = WeeklyTotal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weekly_total_params
      params.require(:weekly_total).permit(:week_number, :week_start, :week_end, :mileage_total, :goal, :met_goal, :hours, :minutes, :seconds, :number_of_runs, :elevation_gain, :notes)
    end
end
