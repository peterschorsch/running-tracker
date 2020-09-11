class RacesController < ApplicationController
  before_action :set_race, only: [:edit, :update, :destroy]

  # GET /personal_bests
  # GET /personal_bests.json
  def index
    @races = Race.all
  end

  # GET /personal_bests/new
  def new
    @race = Race.new
  end

  # GET /personal_bests/1/edit
  def edit
  end

  # POST /personal_bests
  # POST /personal_bests.json
  def create
    @race = Race.new(personal_best_params)

    respond_to do |format|
      if @races.save
        format.html { redirect_to @race, notice: 'Personal best was successfully created.' }
        format.json { render :show, status: :created, location: @race }
      else
        format.html { render :new }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personal_bests/1
  # PATCH/PUT /personal_bests/1.json
  def update
    respond_to do |format|
      if @race.update(race_params)
        format.html { redirect_to @race, notice: 'Personal best was successfully updated.' }
        format.json { render :show, status: :ok, location: @race }
      else
        format.html { render :edit }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personal_bests/1
  # DELETE /personal_bests/1.json
  def destroy
    @race.destroy
    respond_to do |format|
      format.html { redirect_to personal_bests_url, notice: 'Personal best was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def race_params
      params.require(:race).permit(:race, :race_datetime, :hours, :minutes, :seconds, :pace, :notes, :city, :state_id)
    end
end
