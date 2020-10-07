class AllTimeTotal < ApplicationRecord
	has_many :yearly_totals
	belongs_to :user

	scope :of_user, -> (user) {
	    where(user: user)
	}

	def self.create_random_totals(user_id)
		AllTimeTotal.create_with(mileage_total: BigDecimal(rand(3500..10000)), elevation_gain: rand(60000..150000), number_of_runs: rand(500..1000), hours: rand(250..500), minutes: rand(1..59), seconds: rand(1..59)).find_or_create_by(user_id: user_id)
	end

	def update_all_time_totals(run)
		@old_run = Run.find_by(:id => run.id)
		@new_run = run

		self.mileage_total += (@new_run.mileage_total - @old_run.mileage_total) if @new_run.mileage_total != @old_run.mileage_total
		self.number_of_runs += self.user.runs.count

		self.elevation_gain += (@new_run.elevation_gain - @old_run.elevation_gain) if @new_run.elevation_gain != @old_run.elevation_gain

		working_seconds += (@new_run.seconds - @old_run.seconds) if @new_run.seconds != @old_run.seconds
		if @new_run.seconds != @old_run.seconds
			working_seconds += (@new_run.seconds - @old_run.seconds)
		else
			working_seconds = @new_run.seconds
		end
		#working_seconds = self.seconds + run.seconds
		if working_seconds >= 60
			self.minute += 1
			self.seconds = working_seconds-60
		else
			self.seconds = working_seconds
		end
		working_minutes += (@new_run.minutes - @old_run.minutes) if @new_run.minutes != @old_run.minutes
		#working_minutes = self.minutes + run.minutes

		if @new_run.minutes != @old_run.minutes
			working_minutes += (@new_run.minutes - @old_run.minutes)
		else
			working_minutes = @new_run.minutes
		end
		if working_minutes >= 60
			self.hours += 1
			self.minutes = working_minutes-60
		else
			self.minutes = working_minutes
		end
		#working_hours += (@new_run.hours - @old_run.hours) if @new_run.hours != @old_run.hours
		self.hours += (@new_run.hours - @old_run.hours) if @new_run.hours != @old_run.hours

		self.user_id = self.user.id
		self.save
	end

end
