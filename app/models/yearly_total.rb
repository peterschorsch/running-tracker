class YearlyTotal < ApplicationRecord
	belongs_to :user
	belongs_to :all_time_total
	has_many :monthly_totals

	validates :year, :mileage_total, :number_of_runs, :elevation_gain, :hours, :minutes, :seconds, presence: true
	validates :year, uniqueness: true

	validates :hours, length: { in: 1..3 }
	validates :minutes, :seconds, length: { in: 1..2 }
	validates_numericality_of :minutes, less_than_or_equal_to: 60
	validates_numericality_of :seconds, less_than_or_equal_to: 60


	scope :find_by_year, -> (year) {
		find_by(:year => year)
	}

	scope :order_by_year, -> {
		order(:year)
	}

	def self.return_year_totals(year = Date.today.year)
		self.find_by_year(year)
	end
end
