class Admin::TotalRecord::MonthlyTotalsController < Admin::TotalRecords::TotalRecordsController
  def edit
  end

  def update
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthly_total
      @monthly_total = current_user.monthly_totals.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def monthly_total_params
      params.require(:monthly_total).permit(:mileage_total, :number_of_runs, :elevation_gain, :time_in_seconds, :frozen_flag)
    end

end
