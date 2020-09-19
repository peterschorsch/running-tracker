class DashboardsController < ApplicationController

	def index
		@runs = current_user.runs.includes(:run_type)
		### LAST RUN ###
		@last_run = @runs.find_last_completed_run

		### NEXT RUN ###
		@next_run = @runs.find_next_run

		### WEEKLY TOTALS ###
		@weekly_total = current_user.weekly_totals.order_by_recent_week.first

		### MONTHLY TOTALS ###
		@monthly_total = current_user.monthly_totals.of_year.of_month
	end

end
