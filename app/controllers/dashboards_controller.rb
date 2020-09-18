class DashboardsController < ApplicationController

	def index
		@runs = Run.of_user(current_user).includes(:run_type)
		### LAST RUN ###
		@last_run = @runs.find_last_completed_run

		### NEXT RUN ###
		@next_run = @runs.find_next_run

		### WEEKLY TOTALS ###
		@weekly_total = WeeklyTotal.of_user(current_user).of_week_number(Date.current.month).of_year(Date.current.year).first
		@weekly_goal_difference = @weekly_total.mileage_total - @weekly_total.goal
		@weekly_goal_difference = "+" + @weekly_goal_difference.to_s if not @weekly_goal_difference.negative?
		@weekly_goal_difference = @weekly_goal_difference.to_s + " miles"

		### MONTHLY TOTALS ###
		@monthly_total = current_user.monthly_totals.return_current_months_totals

	end

end
