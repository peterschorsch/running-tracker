class StatisticsController < ApplicationController
	def index
		### THIS WEEK TOTALS ###
		@current_week_runs_master = current_user.runs.of_week(Date.current).includes(:run_type)
		@current_week_runs = @current_week_runs_master.includes(gear: :shoe_brand).order_by_most_recent
		@current_week_graph = @current_week_runs_master.order_by_oldest.map { |cwr| [cwr.start_time.strftime("%A"), cwr.mileage_total.to_i] }
		@pie_chart_data = WeeklyTotal.populate_pie_chart(current_user, Date.current)

		### WEEKLY TOTALS ###
		@weekly_totals_master = current_user.weekly_totals
		@weekly_totals = @weekly_totals_master.order_by_recent_week
		@weekly_totals_graph = @weekly_totals_master.order_by_oldest_week.map { |wt| [wt.week_start.strftime("%-m/%-d").to_s + "-" + wt.week_end.strftime("%-m/%-d").to_s, wt.mileage_total.to_i] }
		@pie_chart_data = WeeklyTotal.populate_pie_chart(current_user, Date.current)

		### MONTHLY TOTALS ###
		@monthly_totals_master = current_user.monthly_totals.order_by_recent_month
		@monthly_totals = @monthly_totals_master.first(12)
		@monthly_stats_graph = @monthly_totals.map { |mt| [mt.month_end.strftime("%b '%y"), mt.mileage_total.to_i] }

		### YEARLY TOTALS ###
		@yearly_totals_master = current_user.yearly_totals
		@yearly_totals = @yearly_totals_master.order_by_recent_year
		@yearly_totals_graph = @yearly_totals_master.order_by_oldest_year.map { |yt| [yt.year_end.strftime("%Y"), yt.mileage_total.to_i] }

		### ALL TIME TOTALS ###
		@all_time_stats = current_user.all_time_total
	end
end
