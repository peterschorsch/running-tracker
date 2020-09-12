class YearlyTotal < ApplicationRecord
	validates :year, :mileage_total, :number_of_runs, :elevation_gain, :hours, :minutes, :seconds, presence: true
	validates :year, uniqueness: true

	validates :hours, length: { in: 1..3 }
	validates :minutes, :seconds, length: { in: 1..2 }
	validates_numericality_of :minutes, less_than_or_equal_to: 60
	validates_numericality_of :seconds, less_than_or_equal_to: 60


	scope :find_by_year, -> (year) {
		find_by(:year => year)
	}

	def self.return_year_totals(year = Date.today.year)
		self.find_by_year(year)
	end

	def concat_number_of_runs
		self.number_of_runs.to_s + " runs"
	end

	def concat_total_time
		self.hours.to_s + " hrs " + self.minutes.to_s + " min " + self.seconds.to_s + " sec"
	end
end
