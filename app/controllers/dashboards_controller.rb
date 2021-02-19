class DashboardsController < ApplicationController
	include ControllerNotice
	include UserAuthorization

	before_action :set_weekly_total, only: [:update]
	before_action only: [:update] do
		website_viewer_authorization(dashboards_path)
	end

	def index
		### LAST RUN ###
		@last_runs = current_user.runs.includes(:run_type, :state, :shoe).find_last_completed_runs

		### NEXT RUN ###
		@next_runs = current_user.runs.includes(:run_type, :state).find_next_uncompleted_runs

		### FUTURE RACES ###
		@future_races = current_user.runs.includes(:state).return_future_races.limit(2)

		### WEEKLY TOTALS ###
		@weekly_total = current_user.current_weekly_total
		@weekly_total_graph = current_user.weekly_totals.order_by_oldest_week.map { |wt| [shortened_date_range(wt.week_start, wt.week_end), wt.mileage_total.to_i] }

		### MONTHLY TOTALS ###
		@monthly_total = current_user.current_monthly_total

		### YEARLY TOTALS ###
		@yearly_total = current_user.current_yearly_total
	end

	def update
		@mileage_goal = params[:weekly_total][:mileage_goal].to_i

	    respond_to do |format|
	      if @weekly_total.update(weekly_total_params)
	        format.html { redirect_to dashboards_path, notice: "Your Weekly Mileage Goal was successfully updated to " + bold_text(@mileage_goal.to_s + " mile".pluralize(@mileage_goal) + "!") }
	        format.json { render :index, status: :ok, location: @weekly_total }
	      else
	        format.html { render :index }
	        format.json { render json: @weekly_total.errors, status: :unprocessable_entity }
	      end
	    end
	end

	private
		def set_weekly_total
			@weekly_total = current_user.weekly_totals.find(params[:id])
		end

		def weekly_total_params
			params.require(:weekly_total).permit(:mileage_goal)
		end
end
