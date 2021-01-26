class DashboardsController < ApplicationController
	before_action :set_weekly_total, only: [:update]
	before_action :viewer_authorization, only: [:update]

	def index
		### LAST RUN ###
		@last_run = current_user.runs.includes(:run_type).find_last_completed_run

		### NEXT RUN ###
		@next_run = current_user.runs.includes(:run_type).find_next_uncompleted_run

		### FUTURE RACES ###
		@future_races = current_user.runs.includes(:state).return_future_races

		### WEEKLY TOTALS ###
		@weekly_total = current_user.current_weekly_total
		@weekly_total_graph = current_user.weekly_totals.order_by_oldest_week.map { |wt| [wt.week_start.strftime("%-m/%-d").to_s + "-" + wt.week_end.strftime("%-m/%-d").to_s, wt.mileage_total.to_i] }

		### MONTHLY TOTALS ###
		@monthly_total = current_user.current_monthly_total

		### YEARLY TOTALS ###
		@yearly_total = current_user.current_yearly_total
	end

	def update
		@mileage_goal = params[:weekly_total][:mileage_goal].to_i

	    respond_to do |format|
	      if @weekly_total.update(weekly_total_params)
	        format.html { redirect_to dashboards_path, notice: "Your Weekly Mileage Goal was successfully updated to <strong>#{@mileage_goal.to_s + " mile".pluralize(@mileage_goal)}</strong>!" }
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

		def viewer_authorization
	      if current_user.is_viewer?
	        flash[:alert] = "You are not authorized to do said action."
	        redirect_to dashboards_path
	      end
	    end

end
