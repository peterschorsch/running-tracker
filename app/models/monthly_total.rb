class MonthlyTotal < ApplicationRecord
	belongs_to :user
	belongs_to :yearly_total
	has_many :weekly_totals

	validates :month_number, :month_year, :mileage_total, :minutes, :seconds, :elevation_gain, presence: true
	validates :month_number, length: { maximum: 2 }
	validates :month_year, length: { maximum: 4 }
	validates :mileage_total, :elevation_gain, numericality: true
	validates :hours, numericality: true, length: { maximum: 3 }, allow_nil: true
	validates :minutes, numericality: true, length: { in: 0..2 }
	validates :seconds, numericality: true, length: { in: 1..2 }

	scope :return_current_months_totals, -> {
	    of_month_number.of_month_year.first
	}

	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :of_month_number, -> (month_number = Date.current.month.to_s) {
	    where(month_number: month_number).order_by_month_year
	}

	scope :of_month_year, -> (year = Date.current.year.to_s) {
	    where(month_year: year).order_by_month_number
	}

	scope :order_by_month_number, -> {
	    order(:month_number)
	}

	scope :order_by_month_year, -> {
	    order(:month_year)
	}

end
