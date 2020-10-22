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
		find_by("week_start <= ? AND week_end >= ?", week.beginning_of_week, week.end_of_week) || nil
	end

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

	### CREATE TOTALS FOR LAST FOUR WEEKS ###
	def self.create_random_totals(user_id)
		current_date = DateTime.now
		mileage_total = rand(15..75)
		mileage_goal = 40
		met_goal = mileage_total >= mileage_goal ? true : false
		@weekly_total = WeeklyTotal.create_with(mileage_total: BigDecimal(mileage_total), mileage_goal: BigDecimal(mileage_goal), met_goal: met_goal, hours: rand(5..20), minutes: rand(1..59), seconds: rand(1..59), number_of_runs: rand(1..7), elevation_gain: rand(500..5000)).find_or_create_by(week_start: current_date.beginning_of_week, week_end: current_date.end_of_week, user_id: user_id)
		puts @weekly_total.inspect
		(1..3).each do |number|
			@weekly_total = WeeklyTotal.create_with(mileage_total: rand(5..39), mileage_goal: mileage_goal, met_goal: false, hours: rand(5..20), minutes: rand(1..59), seconds: rand(1..59), number_of_runs: rand(1..7), elevation_gain: rand(500..5000)).find_or_create_by(week_start: current_date.beginning_of_week-number.week, week_end: current_date.end_of_week-number.week, user_id: user_id)
			#@weekly_total = WeeklyTotal.create_with(mileage_total: 0, mileage_goal: mileage_goal, met_goal: false, hours: 0, minutes: 0, seconds: 0, number_of_runs: 0, elevation_gain: 0).find_or_create_by(week_start: current_date.beginning_of_week-number.week, week_end: current_date.end_of_week-number.week, user_id: user_id)
			puts @weekly_total.inspect
		end
		puts ""
	end
end
