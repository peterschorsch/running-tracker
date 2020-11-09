class MonthlyTotal < ApplicationRecord
	belongs_to :user
	has_many :runs
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
		#MonthlyTotal.create_with(mileage_total: 0, elevation_gain: 0, number_of_runs: 0, hours: 0, minutes: 0, seconds: 0).find_or_create_by(user_id: user_id, yearly_total_id: yearly_total_id, month_start: month_start, month_end: month_end) if @monthly_total.nil?
		MonthlyTotal.create_with(mileage_total: BigDecimal(rand(100..250)), elevation_gain: rand(2500..10000), number_of_runs: rand(20..30), hours: rand(12..50), minutes: rand(1..59), seconds: rand(1..59)).find_or_create_by(user_id: user_id, yearly_total_id: yearly_total_id, month_start: month_start, month_end: month_end)
	end


	### REFRESH MONTHLY TOTALS ###
	def self.refresh_monthly_totals(user)
		user.monthly_totals.each do |monthly_total|
			monthly_total.mileage_total = monthly_total.elevation_gain = monthly_total.number_of_runs = monthly_total.hours = monthly_total.minutes = monthly_total.seconds = 0

			@runs = Run.of_month(monthly_total.month_start)

			monthly_total.mileage_total = BigDecimal(@runs.sum(&:mileage_total))
			monthly_total.elevation_gain = @runs.sum(&:elevation_gain)
			monthly_total.number_of_runs = @runs.count

			@runs.each do |run|
				working_seconds = monthly_total.seconds += run.seconds
				if working_seconds >= 60
					monthly_total.minutes += 1
					working_seconds -= 60
				end
				working_minutes = monthly_total.minutes += run.minutes
				if working_minutes >= 60
					monthly_total.hours += 1
					working_minutes -= 60
				end
				monthly_total.hours = monthly_total.hours += run.hours
				monthly_total.minutes = working_minutes
				monthly_total.seconds = working_seconds
			end
			monthly_total.save(:validate => false)
		end
	end
end
