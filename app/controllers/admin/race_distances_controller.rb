class Admin::RaceDistancesController < Admin::AdminControllers
  before_action :set_race_distance, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @race_distance.update(race_distance_params)
        format.html { redirect_to admin_race_examples_path, notice: "<strong>#{@race_distance.name}</strong> was successfully updated." }
        format.json { render :index, status: :ok, location: @race_distance }
      else
        format.html { render :edit }
        format.json { render json: @race_distance.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race_distance
      @race_distance = RaceDistance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def race_distance_params
      params.require(:race_distance).permit(:name, :numeric_distance)
    end
end
