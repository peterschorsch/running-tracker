class YearlyTotalsController < ApplicationController
  before_action :set_yearly_total, only: [:show, :edit, :update, :destroy]

  # GET /yearly_totals
  # GET /yearly_totals.json
  def index
    @yearly_totals = YearlyTotal.all
  end

  # GET /yearly_totals/1
  # GET /yearly_totals/1.json
  def show
  end

  # GET /yearly_totals/new
  def new
    @yearly_total = YearlyTotal.new
  end

  # GET /yearly_totals/1/edit
  def edit
  end

  # POST /yearly_totals
  # POST /yearly_totals.json
  def create
    @yearly_total = YearlyTotal.new(yearly_total_params)

    respond_to do |format|
      if @yearly_total.save
        format.html { redirect_to @yearly_total, notice: 'Yearly total was successfully created.' }
        format.json { render :show, status: :created, location: @yearly_total }
      else
        format.html { render :new }
        format.json { render json: @yearly_total.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /yearly_totals/1
  # PATCH/PUT /yearly_totals/1.json
  def update
    respond_to do |format|
      if @yearly_total.update(yearly_total_params)
        format.html { redirect_to @yearly_total, notice: 'Yearly total was successfully updated.' }
        format.json { render :show, status: :ok, location: @yearly_total }
      else
        format.html { render :edit }
        format.json { render json: @yearly_total.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /yearly_totals/1
  # DELETE /yearly_totals/1.json
  def destroy
    @yearly_total.destroy
    respond_to do |format|
      format.html { redirect_to yearly_totals_url, notice: 'Yearly total was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yearly_total
      @yearly_total = YearlyTotal.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def yearly_total_params
      params.require(:yearly_total).permit(:year, :mileage_total, :hours, :minutes, :seconds, :number_of_runs)
    end
end
