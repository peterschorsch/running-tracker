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

	def self.of_month(date = Date.current)
	    find_by("month_start <= ? AND month_end >= ?", date, date) || nil
	end

	scope :of_year, -> (year = Date.current) {
	    where("month_start >= ? AND month_end <= ?", year.beginning_of_year, year.end_of_year)
	}

	def self.create_zero_totals(user_id, yearly_total_id, month_start, month_end)
		MonthlyTotal.create_with(mileage_total: 0, elevation_gain: 0, number_of_runs: 0, time_in_seconds: 0).find_or_create_by(user_id: user_id, yearly_total_id: yearly_total_id, month_start: month_start, month_end: month_end)
	end

	def self.create_random_totals(user_id, yearly_total_id, month_start, month_end)
		MonthlyTotal.create_with(mileage_total: BigDecimal(rand(100..250)), elevation_gain: rand(2500..10000), number_of_runs: rand(20..30), time_in_seconds: rand(21600..115200)).find_or_create_by(user_id: user_id, yearly_total_id: yearly_total_id, month_start: month_start, month_end: month_end)
	end

	### RECALCULATES MONTHLY TOTALS ###
	### CALLED AFTER A RUN IS UPDATED IN CALENDAR OR RUNS TABLE ###
	def recalculate_monthly_total
		# Return completed runs of the month
		@completed_runs_of_month = self.runs.of_month(self.month_end).completed_runs
		self.update_columns(:mileage_total => @completed_runs_of_month.sum(:mileage_total), :time_in_seconds => @completed_runs_of_month.sum(:time_in_seconds), :number_of_runs => @completed_runs_of_month.count, :elevation_gain => @completed_runs_of_month.sum(:elevation_gain))
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

end
