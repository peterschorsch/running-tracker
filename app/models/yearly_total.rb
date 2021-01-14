class YearlyTotal < ApplicationRecord
	belongs_to :user
	belongs_to :all_time_total
	has_many :monthly_totals, dependent: :destroy

	before_create :set_datetime

	validates :year, :mileage_total, :number_of_runs, :elevation_gain, :time_in_seconds, presence: true
	validates_uniqueness_of :year, :scope => [:all_time_total_id, :user_id]

	validates_numericality_of :time_in_seconds

	scope :order_by_oldest_year, -> {
	    order(:year)
	}

	scope :order_by_recent_year, -> {
	    order(year: :desc)
	}

	def self.of_year(date = Date.current)
		find_by(:year => date.year) || nil
	end

	scope :of_user, -> (user) {
		where(:user => user)
	}

	scope :unfrozen_months, -> {
		where(:frozen_flag => false)
	}

	scope :frozen_months, -> {
		where(:frozen_flag => true)
	}

	def has_been_frozen?
		self.frozen_flag
	end

	### RECALCULATES ALL YEARLY TOTALS ###
	### CALLED AFTER A RUN IS UPDATED IN CALENDAR OR RUNS TABLE ###
	def recalculate_yearly_total
		@completed_runs_of_year = self.user.return_completed_runs.of_year(self.year_start)
		self.update_columns(:mileage_total => BigDecimal(@completed_runs_of_year.sum(&:mileage_total)), :elevation_gain => @completed_runs_of_year.sum(&:elevation_gain), :number_of_runs => @completed_runs_of_year.count, :time_in_seconds => @completed_runs_of_year.sum(&:time_in_seconds))
	end

	def self.create_zero_totals(user_id, all_time_total_id, year = Date.current)
		year_start = year.beginning_of_year
		year_end = year.end_of_year

		YearlyTotal.create_with(mileage_total: BigDecimal('0'), elevation_gain: 0, number_of_runs: 0, time_in_seconds: 0).find_or_create_by(year: year.year, year_start: year_start, 
			year_end: year_end, user_id: user_id, all_time_total_id: all_time_total_id)
	end

	def self.create_random_totals(user_id, all_time_total_id, year = Date.current)
		year_start = year.beginning_of_year
		year_end = year.end_of_year

		YearlyTotal.create_with(mileage_total: BigDecimal(rand(1000..2500)), elevation_gain: rand(22000..60000), number_of_runs: rand(220..310), 
			time_in_seconds: rand(21600..115200)).find_or_create_by(year: year.year, year_start: year_start, 
			year_end: year_end, user_id: user_id, all_time_total_id: all_time_total_id)
	end

	private
	def set_datetime
		self.year_start = self.year_start.beginning_of_year
		self.year_end = self.year_end.end_of_year
	end

end
