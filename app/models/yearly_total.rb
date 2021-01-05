class YearlyTotal < ApplicationRecord
	belongs_to :user
	belongs_to :all_time_total
	has_many :monthly_totals, dependent: :destroy

	validates :year, :mileage_total, :number_of_runs, :elevation_gain, :seconds, presence: true
	validates_uniqueness_of :year, :scope => [:all_time_total_id, :user_id]

	validates_numericality_of :seconds

	scope :order_by_oldest_year, -> {
	    order(:year)
	}

	scope :order_by_recent_year, -> {
	    order(year: :desc)
	}

	scope :of_year, -> (year = Date.today.year) {
		find_by(:year => year)
	}

	scope :of_user, -> (user) {
		where(:user => user)
	}

	def add_to_yearly_total(run)
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

	### REFRESHES ALL YEARLY TOTALS ###
	def self.refresh_yearly_totals(user)
		user.yearly_totals.each do |yearly_total|
			@completed_runs = user.runs.of_year(yearly_total.year_end).return_completed_runs
			yearly_total.update_columns(:mileage_total => BigDecimal(@completed_runs.sum(&:mileage_total)), :elevation_gain => @completed_runs.sum(&:elevation_gain), :number_of_runs => @completed_runs.count, :seconds => @completed_runs.sum(&:seconds))
		end
	end

	def self.create_zero_totals(user_id, all_time_total_id, year = Date.current)
		year_start = year.beginning_of_year.in_time_zone("Pacific Time (US & Canada)")
		year_end = year.end_of_year.in_time_zone("Pacific Time (US & Canada)")

		YearlyTotal.create_with(mileage_total: BigDecimal('0'), elevation_gain: 0, number_of_runs: 0, seconds: 0).find_or_create_by(year: year.year, year_start: year_start, 
			year_end: year_end, user_id: user_id, all_time_total_id: all_time_total_id)
	end

	def self.create_random_totals(user_id, all_time_total_id, year = Date.current)
		year_start = year.beginning_of_year.in_time_zone("Pacific Time (US & Canada)")
		year_end = year.end_of_year.in_time_zone("Pacific Time (US & Canada)")

		YearlyTotal.create_with(mileage_total: BigDecimal(rand(1000..2500)), elevation_gain: rand(22000..60000), number_of_runs: rand(220..310), 
			seconds: rand(21600..115200)).find_or_create_by(year: year.year, year_start: year_start, 
			year_end: year_end, user_id: user_id, all_time_total_id: all_time_total_id)
	end

end
