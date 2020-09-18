class DashboardsController < ApplicationController

	def index
		@runs = Run.of_user(current_user).includes(:run_type)
		@last_run = @runs.find_last_completed_run
		@next_run = @runs.find_next_run

		@weekly_total = WeeklyTotal.of_user(current_user).of_week_number(Date.current.month).of_year(Date.current.year).first
		@weekly_goal_difference = @weekly_total.mileage_total - @weekly_total.goal
		@weekly_goal_difference = "+" + @weekly_goal_difference.to_s if not @weekly_goal_difference.negative?
		@weekly_goal_difference = @weekly_goal_difference.to_s + " miles"
	end

end
