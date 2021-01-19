class Admin::TotalRecord::TotalRecordsController < Admin::AdminController
  def index
    @yearly_totals = current_user.yearly_totals.order_by_recent_year.includes(:monthly_totals)
  end

  def edit_monthly_total
    puts "=================="
    puts "Update MT"
  end

  def update_monthly_total
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_yearly_total
      @yearly_total = current_user.yearly_totals.find(params[:id])
    end

    def set_monthly_total
      @monthly_total = current_user.monthly_totals.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def yearly_total_params
      params.require(:yearly_total).permit(:mileage_total, :number_of_runs, :elevation_gain, :time_in_seconds, :frozen_flag)
    end
    def monthly_total_params
      params.require(:monthly_total).permit(:mileage_total, :number_of_runs, :elevation_gain, :time_in_seconds, :frozen_flag)
    end

end
