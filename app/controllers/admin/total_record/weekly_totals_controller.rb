class Admin::TotalRecord::WeeklyTotalsController < ApplicationController
  before_action :set_weekly_total, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @weekly_total.update(weekly_total_params)
        format.html { redirect_to admin_total_record_root_path, notice: "Weekly Total Record starting <strong>#{@weekly_total.week_start.strftime("%b.%d.%Y")}</strong> was successfully updated." }
      else
        format.html { render :edit }
        format.json { render json: @weekly_total.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_total
      @weekly_total = current_user.weekly_totals.unfrozen_weeks.find(params[:id])
      rescue ActiveRecord::RecordNotFound
      flash[:alert] = "You are not authorized to edit specified Weekly Total."
      redirect_to admin_total_record_root_path
    end

    # Only allow a list of trusted parameters through.
    def weekly_total_params
      params.require(:weekly_total).permit(:mileage_total, :mileage_goal, :met_goal, :number_of_runs, :time_in_seconds, :elevation_gain, :frozen_flag)
    end
end
