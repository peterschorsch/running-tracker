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
		order('start_time DESC')
	}

	scope :find_last_completed_run, -> {
		return_completed_runs.order_by_most_recent.first
	}

	scope :find_next_run, -> {
		return_uncompleted_runs.where("start_time > ?", DateTime.now).first
	}

	def was_completed?
		self.completed_run
	end

	def running_totals
		number_of_runs = actual_mileage = elevation_gain = hours = minutes = seconds = 0
		user_id = self.run.user.id

		number_of_runs += 1
		actual_mileage += run.mileage_total
		elevation_gain += run.elevation_gain
		seconds += run.seconds
		if seconds >= 60
			minutes += 1
			seconds -= 60
		end
		minutes += run.minutes
		if minutes >= 60
			hours += 1
			minutes -= 60
		end
		hours += run.hours
	end

	### RETURNS RUNS FROM LAST 7 DAYS IF NO ARGUMENTS ARE PASSED ###
	def self.retrieve_specific_runs(starting_day = DateTime.now.change(hour: 0)-7.days, ending_day = DateTime.now.end_of_day)
		Run.where(start_time: starting_day..ending_day)
	end

	### CREATE DEFAULT RUNS FOR CURRENT WEEK
	def self.create_weeklong_default_runs(current_user)
		default_shoe_id = Gear.return_default_shoe.id
		state_id = State.find_by_abbr("CA").id
		run_type_id = RunType.default_run_type.id

		# Current Date
		current_date = DateTime.now
		# Starts on a Monday
		week_start_date = current_date.beginning_of_week
		week_end_date = current_date.end_of_week
		loop_week = week_start_date...week_end_date

		loop_week.each_with_index do |date, index|
			@run = Run.find_or_create_by(name: "Default Run #{index+1}", start_time: date,
										hours: 0, minutes: 0, seconds: 0, pace: "0:00", city: "Los Angeles",
										gear_id: default_shoe_id, planned_mileage: BigDecimal('0'),
										elevation_gain: BigDecimal('0'), state_id: state_id, run_type_id: run_type_id,
										user_id: current_user.id, completed_run: false)
		end
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
