class WeeklyTotal < ApplicationRecord
	belongs_to :user

	validates :week_start, :week_end, :mileage_total, :time_in_seconds, :elevation_gain, presence: true
	validates :mileage_total, :elevation_gain, numericality: true
	validates :time_in_seconds, numericality: true

	scope :order_by_oldest_week, -> {
		order(:week_start)
	}

	scope :order_by_recent_week, -> {
		order(week_start: :desc)
	}

	scope :of_user, -> (user) {
		where(user: user)
	}

	def self.of_week(date = Date.current)
		find_by("week_start >= ? AND week_end <= ?", date.beginning_of_week, date.end_of_week) || nil
	end

	scope :return_oldest_weekly_total, -> {
		order_by_oldest_week.first
	}

	scope :return_newest_weekly_total, -> {
	    order_by_recent_week.first
	}

	scope :unfrozen_weeks, -> {
		where(:frozen_flag => false)
	}

	scope :frozen_weeks, -> {
		where(:frozen_flag => true)
	}

	### USED UPON LOGIN TO FREEZE WEEKLY TOTALS THAT ARE NOT CURRENT WEEK ###
	scope :return_unfrozen_weeks_except_past_two_weeks, -> {
		order_by_oldest_week.limit(2)
	}

	def is_frozen?
		self.frozen_flag
	end

	### USED UPON LOGIN TO FREEZE WEEKLY TOTALS THAT ARE NOT CURRENT WEEK ###
	def self.freeze_weekly_total_collection
		self.update_all(frozen_flag: true)
	end

	def return_goal_percentage
		self.percentage_calculation >= 100 ? 100 : self.percentage_calculation
	end

	def return_goal_percentage_over_one_hundred
		self.percentage_calculation
	end

	### STATISTICS PAGE - POPULATE DATA FOR PIE CHART ###
	def self.populate_runtype_pie_chart(runs)
		runs.size.map{ |key, value| [RunType.find(key).name, value] }
	end

	def met_weekly_goal?
		self.met_goal
	end

	def self.set_oldest_weekly_total_to_zero(date = Date.current)
		return_oldest_weekly_total.set_weekly_total_to_zero(date)
	end

	### CREATE FOUR BLANK WEEKLY TOTAL RECORDS ###
	def self.create_four_blank_weekly_totals(user)
		current_date = Date.current
		@weekly_total = WeeklyTotal.create_blank_weekly_total_record(current_date.beginning_of_week, current_date.end_of_week, user)
		puts @weekly_total.inspect

		(1..3).each do |number|
			@weekly_total = WeeklyTotal.create_blank_weekly_total_record(current_date.beginning_of_week-number.week, current_date.end_of_week-number.week, user)
		end
	end

	### CREATE FOUR BLANK WEEKLY TOTAL RECORDS ###
	def self.create_four_random_weekly_totals(user)
		current_date = Date.current
		@weekly_total = WeeklyTotal.create_random_weekly_total_record(current_date.beginning_of_week, current_date.end_of_week, user)

		(1..3).each do |number|
			@weekly_total = WeeklyTotal.create_random_weekly_total_record(current_date.beginning_of_week-number.week, current_date.end_of_week-number.week, user)
		end
	end

	### CREATE WEEKLY TOTAL RECORD WITH ZEROED TOTALS ###
	def self.create_blank_weekly_total_record(week_start, week_end, user)
		WeeklyTotal.create_with(mileage_total: 0, mileage_goal: 0, met_goal: false, time_in_seconds: 0, number_of_runs: 0, elevation_gain: 0, frozen_flag: user.is_viewer?).find_or_create_by(week_start: week_start, week_end: week_end, user_id: user.id)
	end

	### CREATE SINGLE RANDOM WEEKLY TOTAL RECORD
	def self.create_random_weekly_total_record(week_start, week_end, user)
		mileage_total = BigDecimal(rand(5..39))
		mileage_goal = BigDecimal(rand(5..39))
		met_goal = mileage_total >= mileage_goal

		WeeklyTotal.create_with(mileage_total: mileage_total, mileage_goal: mileage_goal, met_goal: met_goal, time_in_seconds: rand(21600..115200), number_of_runs: rand(1..7), elevation_gain: rand(500..5000), frozen_flag: user.is_viewer?).find_or_create_by(week_start: week_start, week_end: week_end, user_id: user.id)
	end

	### FOR WEBSITE VIEWER ###
	### UPDATE WEEKLY TOTAL RECORD TO RANDOM NUMBERS FOR A NEW/CURRENT WEEKLY TOTAL RECORD FOR CURRENT WEEK ###
	def update_random_weekly_total_record(week_start, week_end)
		mileage_total = BigDecimal(rand(5..39))
		mileage_goal = BigDecimal(rand(5..39))
		met_goal = mileage_total >= mileage_goal

		self.update_attributes(mileage_total: mileage_total, mileage_goal: mileage_goal, met_goal: met_goal, time_in_seconds: rand(21600..115200), number_of_runs: rand(1..7), elevation_gain: rand(500..5000), week_start: week_start, week_end: week_end)
	end

	### RECALCULATES USER'S FOUR WEEKLY TOTALS ###
	def recalculate_weekly_total
		@completed_runs_of_week = self.user.return_completed_runs.of_week(self.week_start)
		met_goal = @completed_runs_of_week.sum(:mileage_total) >= self.mileage_goal

		self.update_columns(:mileage_total => BigDecimal(@completed_runs_of_week.sum(&:mileage_total)), met_goal: met_goal, :elevation_gain => @completed_runs_of_week.sum(&:elevation_gain), :number_of_runs => @completed_runs_of_week.count, :time_in_seconds => @completed_runs_of_week.sum(&:time_in_seconds))
	end

	### SET OLDEST WEEKLY TOTAL TO ZERO ###
	def set_weekly_total_to_zero(date = Date.current)
		mileage_goal = self.user.weekly_totals.return_newest_weekly_total.mileage_goal
		self.update_attributes(mileage_total: BigDecimal('0'), mileage_goal: mileage_goal, met_goal: false, time_in_seconds: 0, number_of_runs: 0, elevation_gain: 0, week_start: date.starting_of_week, week_end: date.end_of_week, frozen_flag: false)
	end

	protected
	### DOES NOT RETURN AS DECIMAL ###
	def percentage_calculation
		(self.mileage_total.to_f/self.mileage_goal)*100
	end

	def decimal_percentage_calculation
		self.mileage_total/self.mileage_goal
	end

end
