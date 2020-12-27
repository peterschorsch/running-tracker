class WeeklyTotal < ApplicationRecord
	belongs_to :user

	validates :week_start, :week_end, :mileage_total, :minutes, :seconds, :elevation_gain, presence: true
	validates :mileage_total, :elevation_gain, numericality: true
	validates :hours, numericality: true, length: { maximum: 3 }, allow_nil: true
	validates :minutes, numericality: true, length: { in: 0..2 }
	validates :seconds, numericality: true, length: { in: 1..2 }

	scope :order_by_oldest_week, -> {
		order(:week_start)
	}

	scope :order_by_recent_week, -> {
		order(week_start: :desc)
	}

	scope :of_user, -> (user) {
		where(user: user)
	}

	def self.of_week(week = DateTime.current)
		find_by("week_start >= ? AND week_end <= ?", week.beginning_of_week, week.end_of_week) || nil
	end

	scope :return_oldest_weekly_total, -> {
		order_by_oldest_week.first
	}

	scope :return_newest_weekly_total, -> {
	    order_by_recent_week.first
	}

	def calculate_goal_percentage
		@goal_percentage = (self.mileage_total/self.mileage_goal)*100
		@goal_percentage = @goal_percentage >= 100 ? 100 : @goal_percentage
	end

	def self.populate_pie_chart(user, date)
		@run_types = RunType.active_run_types
		pie_chart_data = []

		@run_types.each do |run_type|
			run_type_count = run_type.runs.of_user(user).of_week(date).count
			pie_chart_data << [run_type.name, run_type_count] if run_type_count > 0
		end
		return pie_chart_data
	end

	def met_weekly_goal?
		self.met_goal
	end

	def update_met_goal_field
		self.met_goal = self.met_weekly_goal?
		self.save(:validate => false)
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
		WeeklyTotal.create_with(mileage_total: 0, mileage_goal: 0, met_goal: false, hours: 0, minutes: 0, seconds: 0, number_of_runs: 0, elevation_gain: 0).find_or_create_by(week_start: week_start, week_end: week_end, user_id: user_id)
	end

	### CREATE SINGLE RANDOM WEEKLY TOTAL RECORD
	def self.create_random_weekly_total_record(week_start, week_end, user_id)
		mileage_total = BigDecimal(rand(5..39))
		mileage_goal = BigDecimal(rand(5..39))
		met_goal = mileage_total >= mileage_goal

		WeeklyTotal.create_with(mileage_total: mileage_total, mileage_goal: mileage_goal, met_goal: met_goal, hours: rand(5..20), minutes: rand(1..59), seconds: rand(1..59), number_of_runs: rand(1..7), elevation_gain: rand(500..5000)).find_or_create_by(week_start: week_start, week_end: week_end, user_id: user_id)
	end

	### UPDATE WEEKLY TOTAL RECORD TO ZERO FOR A NEW/CURRENT WEEKLY TOTAL RECORD FOR CURRENT WEEK ###
	def update_zeroed_weekly_total_record(week_start, week_end)
		self.update_attributes(mileage_total: 0, mileage_goal: 0, met_goal: false, hours: 0, minutes: 0, seconds: 0, number_of_runs: 0, elevation_gain: 0, notes: nil, week_start: week_start, week_end: week_end)
	end

	### FOR WEBSITE VIEWER ###
	### UPDATE WEEKLY TOTAL RECORD TO RANDOM NUMBERS FOR A NEW/CURRENT WEEKLY TOTAL RECORD FOR CURRENT WEEK ###
	def update_random_weekly_total_record(week_start, week_end)
		mileage_total = BigDecimal(rand(5..39))
		mileage_goal = BigDecimal(rand(5..39))
		met_goal = mileage_total >= mileage_goal

		self.update_attributes(mileage_total: mileage_total, mileage_goal: mileage_goal, met_goal: met_goal, hours: rand(5..20), minutes: rand(1..59), seconds: rand(1..59), number_of_runs: rand(1..7), elevation_gain: rand(500..5000), notes: nil, week_start: week_start, week_end: week_end)
	end

	### RECALCULATE WEEKLY TOTALS ###
	def self.refresh_weekly_totals(user)
		user.weekly_totals.each do |weekly_total|
			@runs = Run.of_week(weekly_total.week_start).return_completed_runs

			weekly_total.mileage_total = weekly_total.elevation_gain = weekly_total.number_of_runs = 0

			weekly_total.mileage_total = BigDecimal(@runs.sum(&:mileage_total))
			weekly_total.elevation_gain = @runs.sum(&:elevation_gain)
			weekly_total.number_of_runs = @runs.count

			@runs.each do |run|
				weekly_total.hours = weekly_total.minutes = weekly_total.seconds = 0
				working_seconds = weekly_total.seconds += run.seconds
				if working_seconds >= 60
					weekly_total.minutes += 1
					working_seconds -= 60
				end
				working_minutes = weekly_total.minutes += run.minutes
				if working_minutes >= 60
					weekly_total.hours += 1
					working_minutes -= 60
				end
				weekly_total.hours = weekly_total.hours += run.hours
				weekly_total.minutes = working_minutes
				weekly_total.seconds = working_seconds
			end
			weekly_total.save(:validate => false)
		end
	end

end
