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

	def add_to_all_time_total(run)
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

	### UPDATE ALL TIME TOTAL WITH RUN TOTALS ###
	### CALLED AFTER A RUN IS UPDATED IN CALENDAR OR RUNS TABLE ###
	def update_all_time_total
		# Returns yearly total records in order to sum totals
		@yearly_totals = self.user.yearly_totals
		self.update_columns(:mileage_total => @yearly_totals.sum(:mileage_total), :time_in_seconds => @yearly_totals.sum(:time_in_seconds), :number_of_runs => @yearly_totals.count, :elevation_gain => @yearly_totals.sum(:elevation_gain))
	end

	### REFRESH ALL TIME TOTALS ###
	def self.refresh_all_time_total(user)
		@completed_runs = user.return_completed_runs.select(:id, :mileage_total, :elevation_gain, :time_in_seconds)
		user.all_time_total.update_columns(:mileage_total => BigDecimal(@completed_runs.sum(&:mileage_total)), :elevation_gain => @completed_runs.sum(&:elevation_gain), :number_of_runs => @completed_runs.size, :time_in_seconds => @completed_runs.sum(:time_in_seconds))
	end

end
