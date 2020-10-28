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

	def self.create_random_totals(user_id, all_time_total_id, year = Date.current)
		year_start = year.beginning_of_year.in_time_zone("Pacific Time (US & Canada)")
		year_end = year.end_of_year.in_time_zone("Pacific Time (US & Canada)")

		YearlyTotal.create_with(mileage_total: BigDecimal(rand(1000..2500)), elevation_gain: rand(22000..60000), number_of_runs: rand(220..310), 
			hours: rand(100..200), minutes: rand(1..59), seconds: rand(1..59)).find_or_create_by(year: year.year, year_start: year_start, 
			year_end: year_end, user_id: user_id, all_time_total_id: all_time_total_id)
		#YearlyTotal.create_with(mileage_total: BigDecimal(0), elevation_gain: 0, number_of_runs: 0, hours: 0, minutes: 0, seconds: 0).find_or_create_by(year: year, year_start: year_start, 
			#year_end: year_end, user_id: user_id, all_time_total_id: all_time_total_id)
	end

end
