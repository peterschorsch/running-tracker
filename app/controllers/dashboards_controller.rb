class DashboardsController < ApplicationController

	def index
		@runs = current_user.runs.includes(:run_type)
		### LAST RUN ###
		@last_run = @runs.find_last_completed_run

		### NEXT RUN ###
		@next_run = @runs.find_next_run

		### WEEKLY TOTALS ###
		@weekly_total = current_user.weekly_totals.of_week

		@weekly_total_graph = current_user.weekly_totals.order_by_oldest_week.map { |wt| [wt.week_start.strftime("%-m/%-d").to_s + "-" + wt.week_end.strftime("%-m/%-d").to_s, wt.mileage_total.to_i] }

		### MONTHLY TOTALS ###
		@monthly_total = current_user.monthly_totals.of_month
	end

	def pace_chart
	end

end
