class MonthlyTotalsController < ApplicationController
  before_action :set_monthly_total, only: [:show, :edit, :update, :destroy]

  # GET /monthly_totals
  # GET /monthly_totals.json
  def index
    @monthly_totals = MonthlyTotal.all
  end

  # GET /monthly_totals/1
  # GET /monthly_totals/1.json
  def show
  end

  # GET /monthly_totals/new
  def new
    @monthly_total = MonthlyTotal.new
  end

  # GET /monthly_totals/1/edit
  def edit
  end

  # POST /monthly_totals
  # POST /monthly_totals.json
  def create
    @monthly_total = MonthlyTotal.new(monthly_total_params)

    respond_to do |format|
      if @monthly_total.save
        format.html { redirect_to @monthly_total, notice: 'Monthly total was successfully created.' }
        format.json { render :show, status: :created, location: @monthly_total }
      else
        format.html { render :new }
        format.json { render json: @monthly_total.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /monthly_totals/1
  # PATCH/PUT /monthly_totals/1.json
  def update
    respond_to do |format|
      if @monthly_total.update(monthly_total_params)
        format.html { redirect_to @monthly_total, notice: 'Monthly total was successfully updated.' }
        format.json { render :show, status: :ok, location: @monthly_total }
      else
        format.html { render :edit }
        format.json { render json: @monthly_total.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monthly_totals/1
  # DELETE /monthly_totals/1.json
  def destroy
    @monthly_total.destroy
    respond_to do |format|
      format.html { redirect_to monthly_totals_url, notice: 'Monthly total was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthly_total
      @monthly_total = MonthlyTotal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def monthly_total_params
      params.require(:monthly_total).permit(:month_number, :month_start, :month_end, :mileage_total, :hours, :minutes, :seconds, :number_of_runs, :elevation_gain)
    end
end
