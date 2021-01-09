class MonthlyTotal < ApplicationRecord
	belongs_to :user
	has_many :runs
	belongs_to :yearly_total

	validates :month_start, :month_end, :mileage_total, :time_in_seconds, :elevation_gain, presence: true
	validates :mileage_total, :elevation_gain, numericality: true
	validates :time_in_seconds, numericality: true

	scope :order_by_oldest_month, -> {
	    order(:month_start)
	}

	scope :order_by_recent_month, -> {
	    order(month_start: :desc)
	}

	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :of_month, -> (date = Date.current) {
	    find_by("month_start <= ? AND month_end >= ?", date, date)
	}

	scope :of_year, -> (year = Date.current) {
	    where("month_start >= ? AND month_end <= ?", year.beginning_of_year, year.end_of_year)
	}

	def self.create_zero_totals(user_id, yearly_total_id, month_start, month_end)
		MonthlyTotal.create_with(mileage_total: 0, elevation_gain: 0, number_of_runs: 0, time_in_seconds: 0).find_or_create_by(user_id: user_id, yearly_total_id: yearly_total_id, month_start: month_start, month_end: month_end)
	end

	def self.create_random_totals(user_id, yearly_total_id, month_start, month_end)
		MonthlyTotal.create_with(mileage_total: BigDecimal(rand(100..250)), elevation_gain: rand(2500..10000), number_of_runs: rand(20..30), time_in_seconds: rand(21600..115200)).find_or_create_by(user_id: user_id, yearly_total_id: yearly_total_id, month_start: month_start, month_end: month_end)
	end

	### UPDATE MONTHLY TOTAL WITH RUN TOTALS ###
	### CALLED AFTER A RUN IS UPDATED IN CALENDAR OR RUNS TABLE ###
	def update_monthly_total
		# Return completed runs of the month
		@runs = self.user.runs.of_month(self.month_end).completed_runs
		self.update_columns(:mileage_total => @runs.sum(:mileage_total), :time_in_seconds => @runs.sum(:time_in_seconds), :number_of_runs => @runs.count, :elevation_gain => @runs.sum(:elevation_gain))
	end 


	def add_to_monthly_total(run)
		self.mileage_total+=run.mileage_total
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

	### RECALCULATE MONTHLY TOTALS ###
	def recalculate_monthly_total_numbers(mileage_total, elevation_gain, number_of_runs, time_in_seconds)
		self.update_columns(:mileage_total => mileage_total, :elevation_gain => elevation_gain, :number_of_runs => number_of_runs, :time_in_seconds => time_in_seconds)
	end

	### REFRESHES ALL MONTHLY TOTALS ###
	def self.refresh_monthly_totals(user)
		user.monthly_totals.each do |monthly_total|
			@completed_runs = monthly_total.runs.completed_runs
			monthly_total.update_columns(:mileage_total => BigDecimal(@completed_runs.sum(&:mileage_total)), :elevation_gain => @completed_runs.sum(&:elevation_gain), :number_of_runs => @completed_runs.count, :time_in_seconds => @completed_runs.sum(&:time_in_seconds))
		end
	end
end
