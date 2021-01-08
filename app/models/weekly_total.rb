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

	def self.of_week(date = DateTime.current)
		find_by("week_start >= ? AND week_end <= ?", date.beginning_of_week, date.end_of_week) || nil
	end

	scope :return_oldest_weekly_total, -> {
		order_by_oldest_week.first
	}

	scope :return_newest_weekly_total, -> {
	    order_by_recent_week.first
	}

	def return_goal_percentage
		self.percentage_calculation >= 100 ? 100 : self.percentage_calculation
	end

	def return_goal_percentage_over_one_hundred
		self.percentage_calculation
	end

	def self.populate_runtype_pie_chart(runs)
		runs.group(:run_type_id).count.map{ |key, value| [RunType.find(key).name, value] }
	end

	def met_weekly_goal?
		self.met_goal
	end

	def add_to_current_weekly_total(run)
		self.mileage_total+=run.mileage_total
		self.met_goal = self.met_weekly_goal?
		self.elevation_gain+=run.elevation_gain
		self.number_of_runs = self.number_of_runs+=1

		working_seconds = self.seconds += run.seconds
		if working_seconds >= 60
			self.minutes += 1
			working_seconds -= 60
		end
		working_minutes = self.minutes += run.minutes
		if working_minutes >= 60
			self.hours += 1
			working_minutes -= 60
		end
		self.hours = self.hours += run.hours
		self.minutes = working_minutes
		self.seconds = working_seconds

		self.save(:validate => false)
	end

	### CREATE RANDOM TOTALS FOR LAST FOUR WEEKS ###
	def self.create_random_totals(user_id)
		current_date = DateTime.now
		mileage_total = rand(15..75)
		mileage_goal = 40
		met_goal = mileage_total >= mileage_goal
		@weekly_total = WeeklyTotal.create_with(mileage_total: BigDecimal(mileage_total), mileage_goal: BigDecimal(mileage_goal), met_goal: met_goal, hours: rand(5..20), minutes: rand(1..59), seconds: rand(1..59), number_of_runs: rand(1..7), elevation_gain: rand(500..5000)).find_or_create_by(week_start: current_date.beginning_of_week, week_end: current_date.end_of_week, user_id: user_id)

		(1..3).each do |number|
			@weekly_total = WeeklyTotal.create_random_weekly_total_record(current_date.beginning_of_week-number.week, current_date.end_of_week-number.week, user_id)
		end
	end

	### CREATE FOUR BLANK WEEKLY TOTAL RECORDS ###
	def self.create_four_blank_weekly_totals(user_id)
		current_date = DateTime.now
		@weekly_total = WeeklyTotal.create_blank_weekly_total_record(current_date.beginning_of_week, current_date.end_of_week, user_id)
		puts @weekly_total.inspect

		(1..3).each do |number|
			@weekly_total = WeeklyTotal.create_blank_weekly_total_record(current_date.beginning_of_week-number.week, current_date.end_of_week-number.week, user_id)
		end
	end

	### CREATE FOUR BLANK WEEKLY TOTAL RECORDS ###
	def self.create_four_random_weekly_totals(user_id)
		current_date = DateTime.now
		@weekly_total = WeeklyTotal.create_random_weekly_total_record(current_date.beginning_of_week, current_date.end_of_week, user_id)

		(1..3).each do |number|
			@weekly_total = WeeklyTotal.create_random_weekly_total_record(current_date.beginning_of_week-number.week, current_date.end_of_week-number.week, user_id)
		end
	end

	### CREATE WEEKLY TOTAL RECORD WITH ZEROED TOTALS ###
	def self.create_blank_weekly_total_record(week_start, week_end, user_id)
		WeeklyTotal.create_with(mileage_total: 0, mileage_goal: 0, met_goal: false, time_in_seconds: 0, number_of_runs: 0, elevation_gain: 0).find_or_create_by(week_start: week_start, week_end: week_end, user_id: user_id)
	end

	### CREATE SINGLE RANDOM WEEKLY TOTAL RECORD
	def self.create_random_weekly_total_record(week_start, week_end, user_id)
		mileage_total = BigDecimal(rand(5..39))
		mileage_goal = BigDecimal(rand(5..39))
		met_goal = mileage_total >= mileage_goal

		WeeklyTotal.create_with(mileage_total: mileage_total, mileage_goal: mileage_goal, met_goal: met_goal, time_in_seconds: rand(21600..115200), number_of_runs: rand(1..7), elevation_gain: rand(500..5000)).find_or_create_by(week_start: week_start, week_end: week_end, user_id: user_id)
	end

	def update_weekly_total(week_start, week_end)
		completed_runs_of_week = self.user.runs_of_current_week.return_completed_runs
		met_goal = completed_runs_of_week.sum(:mileage_total) >= self.mileage_goal

		self.update_attributes(mileage_total: completed_runs_of_week.sum(:mileage_total), mileage_goal: self.mileage_goal, met_goal: met_goal, time_in_seconds: completed_runs_of_week.sum(:time_in_seconds), number_of_runs: completed_runs_of_week.count, elevation_gain: completed_runs_of_week.sum(:elevation_gain), week_start: week_start, week_end: week_end)
	end

	### FOR WEBSITE VIEWER ###
	### UPDATE WEEKLY TOTAL RECORD TO RANDOM NUMBERS FOR A NEW/CURRENT WEEKLY TOTAL RECORD FOR CURRENT WEEK ###
	def update_random_weekly_total_record(week_start, week_end)
		mileage_total = BigDecimal(rand(5..39))
		mileage_goal = BigDecimal(rand(5..39))
		met_goal = mileage_total >= mileage_goal

		self.update_attributes(mileage_total: mileage_total, mileage_goal: mileage_goal, met_goal: met_goal, hours: rand(5..20), minutes: rand(1..59), time_in_seconds: rand(1..59), number_of_runs: rand(1..7), elevation_gain: rand(500..5000), notes: nil, week_start: week_start, week_end: week_end)
	end

	### REFRESHES USER'S FOUR WEEKLY TOTALS ###
	def self.refresh_weekly_totals(user)
		user.weekly_totals.each do |weekly_total|
			@completed_runs = user.runs.of_week(weekly_total.week_start).return_completed_runs
			weekly_total.update_columns(:mileage_total => BigDecimal(@completed_runs.sum(&:mileage_total)), :elevation_gain => @completed_runs.sum(&:elevation_gain), :number_of_runs => @completed_runs.count, :time_in_seconds => @completed_runs.sum(&:time_in_seconds))
		end
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
