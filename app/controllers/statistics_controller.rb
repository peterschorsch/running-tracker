class StatisticsController < ApplicationController
	before_action :set_master_totals, only: [:index]

	def index
		### THIS WEEK TOTALS ###
		@current_week_graph = @current_week_runs.order_by_oldest.map { |cwr| [cwr.start_time.strftime("%A"), cwr.mileage_total.to_i] }
		@current_week_runs = @current_week_runs.order_by_most_recent
		@weekly_runtype_counts_data = WeeklyTotal.populate_runtype_pie_chart(@pie_chart_master)
		@weekly_runtype_colors = RunType.all.order_by_id.pluck(:hex_code)

		### WEEKLY TOTALS ###
		@weekly_totals_graph = @weekly_totals.order_by_oldest_week.map { |wt| [wt.week_start.strftime("%-m/%-d").to_s + "-" + wt.week_end.strftime("%-m/%-d").to_s, wt.mileage_total.to_i] }
		@weekly_totals = @weekly_totals.order_by_recent_week

		### MONTHLY TOTALS ###
		@monthly_stats_graph = @monthly_totals.map { |mt| [mt.month_end.strftime("%b '%y"), mt.mileage_total.to_i] }.reverse

		### YEARLY TOTALS ###
		@yearly_totals_graph = @yearly_totals.order_by_oldest_year.map { |yt| [yt.year_end.strftime("%Y"), yt.mileage_total.to_i] }
		@yearly_totals = current_user.yearly_totals.order_by_recent_year

		### ALL TIME TOTALS ###
		@all_time_stats = current_user.all_time_total
	end

	def recalculate_stats
		respond_to do |format|
			if current_user.recalculate_all_user_totals_and_shoes
				format.html { redirect_to statistics_path, notice: "<strong>#{current_user.concat_name}'s</strong> totals were successfully updated." }
				format.json { render :new, status: :created, location: @run }
			else
				format.html { render :new }
				format.json { render json: @run.errors, status: :unprocessable_entity }
			end
		end
	end

	private
	def set_master_totals
		### THIS WEEK TOTALS ###
		@current_week_runs = current_user.runs_of_current_week.includes(:run_type, shoe: :shoe_brand)
		@pie_chart_master = @current_week_runs.order_by_runtype.group(:run_type_id)

		### WEEKLY TOTALS ###
		@weekly_totals = current_user.weekly_totals

		### MONTHLY TOTALS ###
		@monthly_totals = current_user.monthly_totals.order_by_recent_month.first(13)

		### YEARLY TOTALS ###
		@yearly_totals = current_user.yearly_totals
	end
end
