class MonthlyTotal < ApplicationRecord
	belongs_to :user
	belongs_to :yearly_total

	validates :month_start, :month_end, :mileage_total, :minutes, :seconds, :elevation_gain, presence: true
	validates :mileage_total, :elevation_gain, numericality: true
	validates :hours, numericality: true, length: { maximum: 3 }, allow_nil: true
	validates :minutes, numericality: true, length: { in: 0..2 }
	validates :seconds, numericality: true, length: { in: 1..2 }

	scope :order_by_oldest_month, -> {
	    order(:month_start)
	}

	scope :order_by_recent_month, -> {
	    order(month_start: :desc)
	}

	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :of_month, -> (date = Date.current) {
	    find_by("month_start <= ? AND month_end >= ?", date, date)
	}

	scope :of_year, -> (year = Date.current) {
	    where("month_start >= ? AND month_end <= ?", year.beginning_of_year, year.end_of_year)
	}

	def self.create_random_totals(user_id, yearly_total_id, month_start, month_end)
		MonthlyTotal.create_with(mileage_total: BigDecimal(rand(100..250)), elevation_gain: rand(2500..10000), number_of_runs: rand(20..30), hours: rand(12..50), minutes: rand(1..59), seconds: rand(1..59)).find_or_create_by(user_id: user_id, yearly_total_id: yearly_total_id, month_start: month_start, month_end: month_end)
	end

end
