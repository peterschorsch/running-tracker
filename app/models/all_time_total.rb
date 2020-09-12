class AllTimeTotal < ApplicationRecord
	has_many :yearly_totals
	belongs_to :user

	scope :of_user, -> (user) {
	    where(user: user)
	}

	def self.update_all_time_totals(run)
		self.mileage_total += run.distance
		self.number_of_runs += 1
		self.elevation_gain += run.elevation_gain
		working_seconds = self.seconds + run.seconds
		if working_seconds >= 60
			self.minute += 1
			self.seconds = working_seconds-60
		else
			self.seconds = working_seconds
		end
		working_minutes = self.minutes + run.minutes
		if working_seconds >= 60
			self.hours += 1
			self.minutes = working_minutes-60
		else
			self.minutes = working_minutes
		end
		self.hours += run.hours
		self.save
	end

end
