class RaceDistancesController < ApplicationController
  before_action :set_race_distance, only: [:edit, :update, :destroy]

  # GET /race_distances
  # GET /race_distances.json
  def index
    @race_distances = RaceDistance.all
  end

  # GET /race_distances/new
  def new
    @race_distance = RaceDistance.new
  end

  # GET /race_distances/1/edit
  def edit
  end

  # POST /race_distances
  # POST /race_distances.json
  def create
    @race_distance = RaceDistance.new(race_distance_params)

    respond_to do |format|
      if @race_distance.save
        format.html { redirect_to race_distances_path, notice: "#{@race_distance.distance} was successfully created." }
        format.json { render :index, status: :created, location: @race_distance }
      else
        format.html { render :new }
        format.json { render json: @race_distance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /race_distances/1
  # PATCH/PUT /race_distances/1.json
  def update
    respond_to do |format|
      if @race_distance.update(race_distance_params)
        format.html { redirect_to race_distances_path, notice: "#{@race_distance.distance} was successfully updated." }
        format.json { render :index, status: :ok, location: @race_distance }
      else
        format.html { render :edit }
        format.json { render json: @race_distance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /race_distances/1
  # DELETE /race_distances/1.json
  def destroy
    @race_distance.destroy
    respond_to do |format|
      format.html { redirect_to race_distances_path, notice: "#{@race_distance.distance} was successfully removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race_distance
      @race_distance = RaceDistance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def race_distance_params
      params.require(:race_distance).permit(:name, :distance_miles)
    end
end
