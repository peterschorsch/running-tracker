class DashboardsController < ApplicationController

	def index
		@runs = current_user.runs.includes(:run_type)
		### LAST RUN ###
		@last_run = @runs.find_last_completed_run

		### NEXT RUN ###
		@next_run = @runs.find_next_run

		### WEEKLY TOTALS ###
		@weekly_total = Run.return_weekly_stats(current_user, Date.current)
		#@weekly_goal_difference = @weekly_total.mileage_total - @weekly_total.goal
		#@weekly_goal_difference = "+" + @weekly_goal_difference.to_s if not @weekly_goal_difference.negative?
		#@weekly_goal_difference = @weekly_goal_difference.to_s + " miles"

		### MONTHLY TOTALS ###
		@monthly_total = current_user.monthly_totals.of_year.of_month

	end

end
