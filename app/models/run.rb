class Run < ApplicationRecord
	belongs_to :user
	belongs_to :gear
	belongs_to :state
	belongs_to :run_type

	validates :name, :start_time, :mileage_total, :minutes, :seconds, :elevation_gain, :city, presence: true
	validates :mileage_total, :elevation_gain, numericality: true
	validates :hours, numericality: true, length: { maximum: 3 }, allow_nil: true
	validates :minutes, numericality: true, length: { in: 0..2 }
	validates :seconds, numericality: true, length: { in: 1..2 }


	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :of_run_type, -> (run_type) {
	    where(run_type: run_type)
	}

	# Requires DateTime
	scope :of_day, -> (day) {
	    where(start_time: day.beginning_of_day..day.end_of_day)
	}

	scope :of_week, -> (week) {
	    where(start_time: week.beginning_of_week..week.end_of_week)
	}

	scope :of_month, -> (month) {
	    where(start_time: month.beginning_of_month..month.end_of_month)
	}

	scope :of_year, -> (year) {
	    where(start_time: year.beginning_of_year..year.end_of_year)
	}

	scope :group_by_year, -> {
	    group_by { |y| y.start_time.beginning_of_year }
	}

	scope :retrieve_personal_bests, -> {
		joins(:run_type).where("run_types.name=? AND runs.personal_best=?", "Race", true).order(:mileage_total).includes(:state)
	}

	scope :return_completed_runs, -> {
		where(:completed_run=>true)
	}

	scope :return_uncompleted_runs, -> {
		where(:completed_run=>false)
	}

	scope :order_by_most_recent, -> {
		order('start_time DESC')
	}

	scope :order_by_oldest, -> {
		order(:start_time)
	}

	scope :find_last_completed_run, -> {
		return_completed_runs.order_by_most_recent.first
	}

	# Used on Current User's Runs
	def self.find_next_run
		return_uncompleted_runs.find_by("start_time > ?", DateTime.now) || nil
	end

	def was_completed?
		self.completed_run
	end

	def self.return_race_distance_counts
		totals = self.group(:mileage_total).count
		mappings = { BigDecimal('3.1') => '5K', BigDecimal('6.2') => '10K', BigDecimal('13.1') => 'Half Marathon', BigDecimal('26.2') => 'Marathon' }
		return totals.transform_keys(&mappings.method(:[]))
	end

	def subtract_from_running_totals(total_record)
		total_record.mileage_total-=self.mileage_total
		total_record.elevation_gain-=self.elevation_gain
		total_record.number_of_runs = total_record.number_of_runs-=1

		working_seconds = total_record.seconds -= self.seconds
		if working_seconds < 0
			total_record.minutes -= 1
			working_seconds = working_seconds * -1
		end
		working_minutes = total_record.minutes -= self.minutes
		if working_minutes >= 60
			total_record.hours -= 1
			working_minutes -= 60
		end
		total_record.hours = total_record.hours -= self.hours
		total_record.minutes = working_minutes
		total_record.seconds = working_seconds

		total_record.save(:validate => false)
	end

	def update_user_run_totals(total_record)
		total_record.mileage_total+=self.mileage_total
		total_record.elevation_gain+=self.elevation_gain
		total_record.number_of_runs = total_record.number_of_runs+=1

		working_seconds = total_record.seconds += self.seconds
		if working_seconds >= 60
			total_record.minutes += 1
			working_seconds -= 60
		end
		working_minutes = total_record.minutes += self.minutes
		if working_minutes >= 60
			total_record.hours += 1
			working_minutes -= 60
		end
		total_record.hours = total_record.hours += self.hours
		total_record.minutes = working_minutes
		total_record.seconds = working_seconds

		total_record.save(:validate => false)
	end

	### RETURNS RUNS FROM LAST 7 DAYS IF NO ARGUMENTS ARE PASSED ###
	def self.retrieve_specific_runs(starting_day = DateTime.now.change(hour: 0)-7.days, ending_day = DateTime.now.end_of_day)
		Run.where(start_time: starting_day..ending_day)
	end


	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def self.copy_last_weeks_runs(current_user)
		# Last week's Date
		last_week_date = DateTime.now-1.week
		# Starts on a Monday
		week_start_date = last_week_date.beginning_of_week
		week_end_date = last_week_date.end_of_week

		default_shoe_id = Gear.return_default_shoe.id
		default_run_type_id = RunType.default_run_type.id

		@last_weeks_runs = Run.of_user(current_user).where(:start_time => week_start_date..week_end_date)
		@last_weeks_runs.each do |run|
			@run = Run.find_or_create_by(name: run.name, start_time: run.start_time+1.week,
										hours: BigDecimal('0'), minutes: BigDecimal('0'), seconds: BigDecimal('0'), pace: "0:00", city: run.city,
										gear_id: default_shoe_id, planned_mileage: run.planned_mileage,
										elevation_gain: BigDecimal('0'), state_id: run.state_id, run_type_id: default_run_type_id,
										user_id: current_user.id, completed_run: false)
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def self.copy_current_weeks_runs(current_user)
		# Current week's Date
		current_week_date = DateTime.now
		# Starts on a Monday
		current_start_date = current_week_date.beginning_of_week
		current_end_date = current_week_date.end_of_week

		default_shoe_id = Gear.return_default_shoe.id

		@current_weeks_runs = Run.of_user(current_user).where(:start_time => current_start_date..current_end_date)
		@current_weeks_runs.each do |run|
			@run = Run.find_or_create_by(name: run.name, start_time: run.start_time+1.week,
										hours: BigDecimal('0'), minutes: BigDecimal('0'), seconds: BigDecimal('0'), pace: "0:00", city: run.city,
										gear_id: default_shoe_id, planned_mileage: run.planned_mileage,
										elevation_gain: BigDecimal('0'), state_id: run.state_id, run_type_id: run.run_type.id,
										user_id: current_user.id, completed_run: false)
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def self.copy_until_specific_date(current_user, week_date)
		# Current Week's Date
		current_week_date = DateTime.now
		# Current Week's Start & End Dates
		current_week_start_date = current_week_date.beginning_of_week
		current_week_end_date = current_week_date.end_of_week

		# Next Week's Date
		next_week_date = current_week_date+1.week
		# Next Week's Start Date
		next_week_start_date = next_week_date.beginning_of_week

		# End Week's Start Date
		end_week_start_date = week_date.beginning_of_week

		default_shoe_id = Gear.return_default_shoe.id

		number_of_weeks = end_week_start_date.cweek - next_week_start_date.cweek

		@current_weeks_runs = Run.of_user(current_user).where(:start_time => current_week_start_date..current_week_end_date)

		@current_weeks_runs.each do |run|
			if number_of_weeks > 0
				(1..number_of_weeks+1).each do |number|
					running_date = run.start_time + number.week

					@run = Run.find_or_create_by(name: run.name, start_time: running_date,
											hours: BigDecimal('0'), minutes: BigDecimal('0'), seconds: BigDecimal('0'), pace: "0:00", city: run.city,
											gear_id: default_shoe_id, planned_mileage: run.planned_mileage,
											elevation_gain: BigDecimal('0'), state_id: run.state_id, run_type_id: run.run_type.id,
											user_id: current_user.id, completed_run: false)
				end
			end
		end
	end
end
