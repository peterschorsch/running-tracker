class StatisticsController < ApplicationController
	before_action :set_master_totals, only: [:index]

	def index
		### THIS WEEK TOTALS ###
		@current_week_runs = @current_week_runs_master.includes(gear: :shoe_brand).order_by_most_recent
		@current_week_graph = @current_week_runs_master.order_by_oldest.map { |cwr| [cwr.start_time.strftime("%A"), cwr.mileage_total.to_i] }
		@weekly_runtype_counts_data = WeeklyTotal.populate_runtype_pie_chart(@current_week_runs)

		### WEEKLY TOTALS ###
		@weekly_totals = @weekly_totals_master.order_by_recent_week
		@weekly_totals_graph = @weekly_totals_master.order_by_oldest_week.map { |wt| [wt.week_start.strftime("%-m/%-d").to_s + "-" + wt.week_end.strftime("%-m/%-d").to_s, wt.mileage_total.to_i] }

		### MONTHLY TOTALS ###
		@monthly_totals = @monthly_totals_master.first(13)
		@monthly_stats_graph = @monthly_totals.map { |mt| [mt.month_end.strftime("%b '%y"), mt.mileage_total.to_i] }.reverse

		### YEARLY TOTALS ###
		@yearly_totals = @yearly_totals_master.order_by_recent_year
		@yearly_totals_graph = @yearly_totals_master.order_by_oldest_year.map { |yt| [yt.year_end.strftime("%Y"), yt.mileage_total.to_i] }

		### ALL TIME TOTALS ###
		@all_time_stats = current_user.all_time_total
	end

	def refresh_stats
		respond_to do |format|
			if current_user.refresh_all_user_totals
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
		@current_week_runs_master = current_user.current_runs_of_week.includes(:run_type)

		### WEEKLY TOTALS ###
		@weekly_totals_master = current_user.weekly_totals

		### MONTHLY TOTALS ###
		@monthly_totals_master = current_user.monthly_totals.order_by_recent_month

		### YEARLY TOTALS ###
		@yearly_totals_master = current_user.yearly_totals
	end
end
