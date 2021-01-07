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

	### REFRESH ALL TIME TOTALS ###
	def self.refresh_all_time_total(user)
		@completed_runs = user.runs.return_completed_runs
		user.all_time_total.update_columns(:mileage_total => BigDecimal(@completed_runs.sum(&:mileage_total)), :elevation_gain => @completed_runs.sum(&:elevation_gain), :number_of_runs => @completed_runs.count, :seconds => @completed_runs.sum(:seconds))
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
