class AllTimeTotal < ApplicationRecord
	has_many :yearly_totals, dependent: :destroy
	belongs_to :user

	scope :of_user, -> (user) {
	    where(user: user)
	}

	def self.create_zero_totals(user_id)
		AllTimeTotal.create_with(mileage_total: BigDecimal(0), elevation_gain: 0, number_of_runs: 0, time_in_seconds: 0).find_or_create_by(user_id: user_id)
	end

	def self.create_random_totals(user_id)
		AllTimeTotal.create_with(mileage_total: BigDecimal(rand(3500..10000)), elevation_gain: rand(60000..150000), number_of_runs: rand(500..1000), time_in_seconds: rand(21600..115200)).find_or_create_by(user_id: user_id)
	end

	### REFRESH ALL TIME TOTALS ###
	### CALLED AFTER A RUN IS UPDATED IN CALENDAR OR RUNS TABLE ###
	def recalculate_all_time_total
		# Returns yearly total records in order to sum totals
		@yearly_totals = self.yearly_totals
		self.update_columns(:mileage_total => @yearly_totals.sum(:mileage_total), :time_in_seconds => @yearly_totals.sum(:time_in_seconds), :number_of_runs => @yearly_totals.count, :elevation_gain => @yearly_totals.sum(:elevation_gain))
	end

end
