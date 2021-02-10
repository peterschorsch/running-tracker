class MonthlyTotal < ApplicationRecord
	extend Modules::TotalRecord
	include Modules::FrozenRecord

	belongs_to :user
	has_many :runs
	belongs_to :yearly_total

	validates :month_start, :month_end, :time_in_seconds, :elevation_gain, presence: true

	before_save :calculate_mileage_total, :calculate_number_of_runs, :calculate_elevation_gain, :calculate_time_in_seconds


	scope :order_by_oldest_month, -> {
	    order(:month_start)
	}

	scope :order_by_recent_month, -> {
	    order(month_start: :desc)
	}

	def self.of_month(date = Date.current)
	    find_by("month_start >= ? AND month_end <= ?", date.beginning_of_month, date.end_of_month) || nil
	end

	scope :of_year, -> (year = Date.current) {
		where("month_start >= ? AND month_end <= ?", year.beginning_of_year, year.end_of_year)
	}

	### USED UPON LOGIN TO FREEZE MONTHLY TOTALS THAT ARE NOT CURRENT MONTH ###
	scope :return_unfrozen_months_except_current_month, -> {
		unfrozen_records.where.not(:month_start => Date.current.beginning_of_month)
	}

	def self.create_zero_totals(user_id, yearly_total_id, month_start, month_end)
		MonthlyTotal.create_with(new_mileage: 0, mileage_total: 0, new_elevation_gain: 0, elevation_gain: 0, new_number_of_runs: 0, number_of_runs: 0, new_time_in_seconds: 0, time_in_seconds: 0).find_or_create_by(user_id: user_id, yearly_total_id: yearly_total_id, month_start: month_start, month_end: month_end)
	end

	def self.create_random_totals(user_id, yearly_total_id, month_start, month_end)
		MonthlyTotal.create_with(mileage_total: BigDecimal(rand(100..250)), elevation_gain: rand(2500..10000), number_of_runs: rand(20..30), time_in_seconds: rand(21600..115200)).find_or_create_by(user_id: user_id, yearly_total_id: yearly_total_id, month_start: month_start, month_end: month_end)
	end

	### RECALCULATES MONTHLY TOTALS ###
	### CALLED AFTER A RUN IS UPDATED IN CALENDAR OR RUNS TABLE ###
	def recalculate_monthly_total
		# Return completed runs of the month
		@completed_runs_of_month = self.runs.of_month(self.month_end).completed_runs
		new_mileage_for_month = @completed_runs_of_month.sum(:mileage_total)
		new_time_in_seconds_for_month = @completed_runs_of_month.sum(:time_in_seconds)
		new_number_of_runs_for_month = @completed_runs_of_month.count
		new_elevation_gain_for_month = @completed_runs_of_month.sum(:elevation_gain)

		self.update_columns(:new_mileage => new_mileage_for_month, :mileage_total => self.previous_mileage + new_mileage_for_month, :time_in_seconds => self.previous_time_in_seconds + new_time_in_seconds_for_month, :number_of_runs => self.previous_number_of_runs + new_number_of_runs_for_month, :elevation_gain => self.previous_elevation_gain + new_elevation_gain_for_month)
	end

	private
	### ADD MILEAGE FIELDS TOGETHER ###
	def calculate_mileage_total
		self.mileage_total = self.previous_mileage + self.new_mileage
	end

	### ADD NUMBER OF RUNS TOGETHER ###
	def calculate_number_of_runs
		self.number_of_runs = self.previous_number_of_runs + self.new_number_of_runs
	end

	### ADD ELEVATION TOGETHER ###
	def calculate_elevation_gain
		self.elevation_gain = self.previous_elevation_gain + self.new_elevation_gain
	end

	### ADD TIME IN SECONDS TOGETHER ###
	def calculate_time_in_seconds
		self.time_in_seconds = self.previous_time_in_seconds + self.new_time_in_seconds
	end

end
