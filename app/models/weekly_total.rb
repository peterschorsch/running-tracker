class WeeklyTotal < ApplicationRecord
	belongs_to :user

	validates :week_number, :week_year, :mileage_total, :minutes, :seconds, :elevation_gain, presence: true
	validates :week_number, length: { maximum: 2 }
	validates :week_year, length: { maximum: 4 }
	validates :mileage_total, :elevation_gain, numericality: true
	validates :hours, numericality: true, length: { maximum: 3 }, allow_nil: true
	validates :minutes, numericality: true, length: { in: 0..2 }
	validates :seconds, numericality: true, length: { in: 1..2 }

	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :of_week_number, -> (week_number) {
	    where(week_number: week_number).order_by_week_year
	}

	scope :of_year, -> (year) {
	    where("week_year = ?", year).order_by_week_number
	}

	scope :order_by_week_number, -> {
	    order(:week_number)
	}

	scope :order_by_week_year, -> {
	    order(:week_year)
	}

end
