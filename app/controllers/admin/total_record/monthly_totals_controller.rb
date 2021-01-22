class Admin::TotalRecord::MonthlyTotalsController < Admin::TotalRecord::TotalRecordsController
  before_action :set_monthly_total, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @monthly_total.update(monthly_total_params)
        format.html { redirect_to admin_total_record_root_path, notice: "<strong>#{@monthly_total.month_start.strftime("%B %Y")}</strong> was successfully updated." }
      else
        format.html { render :edit }
        format.json { render json: @monthly_total.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_monthly_total
      @monthly_total = current_user.monthly_totals.unfrozen_months.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "You are not authorized to view specified Monthly Total."
      redirect_to admin_total_record_root_path
    end

    # Only allow a list of trusted parameters through.
    def monthly_total_params
      params.require(:monthly_total).permit(:mileage_total, :number_of_runs, :elevation_gain, :time_in_seconds, :frozen_flag)
    end

end
