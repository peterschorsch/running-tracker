class YearlyTotal < ApplicationRecord
	belongs_to :user
	belongs_to :all_time_total
	has_many :monthly_totals, dependent: :destroy

	validates :year, :mileage_total, :number_of_runs, :elevation_gain, :hours, :minutes, :seconds, presence: true
	validates_uniqueness_of :year, :scope => [:all_time_total_id, :user_id]

	validates :hours, length: { in: 1..3 }
	validates :minutes, :seconds, length: { in: 1..2 }
	validates_numericality_of :minutes, less_than_or_equal_to: 60
	validates_numericality_of :seconds, less_than_or_equal_to: 60

	scope :order_by_oldest_year, -> {
	    order(:year)
	}

	scope :order_by_recent_year, -> {
	    order(year: :desc)
	}

	scope :of_year, -> (year = Date.today.year) {
		find_by(:year => year)
	}

	scope :of_current_year, -> {
		find_by(:year => Date.today.year)
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

	### RECALCULATE YEARLY TOTALS ###
	def self.refresh_yearly_totals(user)
		user.yearly_totals.each do |yearly_total|
			yearly_total.mileage_total = yearly_total.elevation_gain = yearly_total.number_of_runs = yearly_total.hours = yearly_total.minutes = yearly_total.seconds = 0

			@runs = user.runs.of_year(yearly_total.year_start).return_completed_runs

			yearly_total.mileage_total = BigDecimal(@runs.sum(&:mileage_total))
			yearly_total.elevation_gain = @runs.sum(&:elevation_gain)
			yearly_total.number_of_runs = @runs.count

			@runs.each do |run|
				working_seconds = yearly_total.seconds += run.seconds
				if working_seconds >= 60
					yearly_total.minutes += 1
					working_seconds -= 60
				end
				working_minutes = yearly_total.minutes += run.minutes
				if working_minutes >= 60
					yearly_total.hours += 1
					working_minutes -= 60
				end
				yearly_total.hours = yearly_total.hours += run.hours
				yearly_total.minutes = working_minutes
				yearly_total.seconds = working_seconds
			end
			yearly_total.save(:validate => false)
		end
	end

	def self.create_zero_totals(user_id, all_time_total_id, year = Date.current)
		year_start = year.beginning_of_year.in_time_zone("Pacific Time (US & Canada)")
		year_end = year.end_of_year.in_time_zone("Pacific Time (US & Canada)")

		YearlyTotal.create_with(mileage_total: BigDecimal('0'), elevation_gain: 0, number_of_runs: 0, hours: 0, minutes: 0, seconds: 0).find_or_create_by(year: year.year, year_start: year_start, 
			year_end: year_end, user_id: user_id, all_time_total_id: all_time_total_id)
	end

	def self.create_random_totals(user_id, all_time_total_id, year = Date.current)
		year_start = year.beginning_of_year.in_time_zone("Pacific Time (US & Canada)")
		year_end = year.end_of_year.in_time_zone("Pacific Time (US & Canada)")

		YearlyTotal.create_with(mileage_total: BigDecimal(rand(1000..2500)), elevation_gain: rand(22000..60000), number_of_runs: rand(220..310), 
			hours: rand(100..200), minutes: rand(1..59), seconds: rand(1..59)).find_or_create_by(year: year.year, year_start: year_start, 
			year_end: year_end, user_id: user_id, all_time_total_id: all_time_total_id)
	end

end
