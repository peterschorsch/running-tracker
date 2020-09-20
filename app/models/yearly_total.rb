class YearlyTotal < ApplicationRecord
	belongs_to :user
	belongs_to :all_time_total
	has_many :monthly_totals

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

	scope :of_user, -> (user) {
		where(:user => user)
	}

end
