class Admin::TotalRecord::YearlyTotalsController < Admin::TotalRecord::TotalRecordsController
  before_action :set_yearly_total, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @yearly_total.update(yearly_total_params)
        format.html { redirect_to admin_total_record_root_path, notice: "<strong>#{@yearly_total.year}</strong> was successfully updated." }
      else
        format.html { render :edit }
        format.json { render json: @yearly_total.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yearly_total
      @yearly_total = current_user.yearly_totals.unfrozen_years.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "You are not authorized to view specified Yearly Total."
      redirect_to admin_total_record_root_path
    end

    # Only allow a list of trusted parameters through.
    def yearly_total_params
      params.require(:yearly_total).permit(:mileage_total, :number_of_runs, :elevation_gain, :time_in_seconds, :frozen_flag)
    end
end
