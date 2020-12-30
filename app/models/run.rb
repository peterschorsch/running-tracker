class Run < ApplicationRecord
	belongs_to :user
	belongs_to :monthly_total
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

	scope :return_runs_on_date, -> (month, day, year) {
	    where(start_time: Date.new(year, month, day).all_day)
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

	scope :return_past_uncompleted_runs, -> {
		where("start_time < ?", Date.current).return_uncompleted_runs
	}

	scope :order_by_most_recent, -> {
		order('start_time DESC')
	}

	scope :order_by_oldest, -> {
		order(:start_time)
	}

	scope :order_by_fastest, -> {
		order('hours, minutes, seconds')
	}

	scope :find_last_completed_run, -> {
		return_completed_runs.order_by_most_recent.first
	}

	scope :return_races, -> {
		joins(:run_type).where("run_types.name=?", "Race").return_completed_runs
	}

	scope :return_5k_results, -> {
		where(mileage_total: BigDecimal('3.1')).return_completed_runs
	}

	scope :return_10k_results, -> {
		where(mileage_total: BigDecimal('6.2')).return_completed_runs
	}

	scope :return_hm_results, -> {
		where(mileage_total: BigDecimal('13.1')).return_completed_runs
	}

	scope :return_fm_results, -> {
		where(mileage_total: BigDecimal('26.2')).return_completed_runs
	}

	# Used on Current User's Runs
	# Finds next uncompleted run
	def self.find_next_uncompleted_run
		return_uncompleted_runs.find_by("start_time >= ?", DateTime.now.beginning_of_day..DateTime.now.end_of_day) || nil
	end

	def was_completed?
		self.completed_run
	end

	### AN ACTIVE RUN COUNTS ON TOTALS, WHILE AN INACTIVE RUN IS ONE THAT HAS BEEN "REMOVED" BY THE USER
	def is_active?
		self.active_run
	end

	def is_event?
		self.event_flag
	end

	def self.return_random_run_start_time(date = Date.current)
		DateTime.new(date.year, date.month, date.day, rand(7..8), [0,30].sample, 0).in_time_zone("Pacific Time (US & Canada)")
	end

	def make_run_inactive
		self.active_run = false
		self.save(:validate => false)
	end

	def hex_code
		self.run_type.hex_code
	end

	def self.return_random_pace
		rand(6..10).to_s + ":" + rand(0..59).to_s.rjust(2, '0')
	end

	def self.return_random_hours
		rand(0..3)
	end

	def self.return_random_minutes
		BigDecimal(rand(1..59).to_s.rjust(2, '0'))
	end

	def self.return_random_seconds
		BigDecimal(rand(0..59).to_s.rjust(2, '0'))
	end

	def self.return_random_elevation_gain
		BigDecimal(rand(50..1000))
	end

	def self.return_race_distance_counts
		totals = self.group(:mileage_total).count
		#totals = totals.reject { |k,v| k != BigDecimal('3.1') || k != BigDecimal('6.2') || k != BigDecimal('13.2') || k != BigDecimal('26.2') }
		puts totals.inspect
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

	### UPDATE TOTALS WHILE WITH TOTAL RECORD PARAMS USING RUN RECORD ###
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

	### CREATE RANDOM COMPLETED RUN ###
	def self.create_random_run_record(name, start_time, completed_run, active_run, gear_id, city, state_id, run_type_id, monthly_total_id, user_id)
		Run.create_with(name: name, planned_mileage: BigDecimal(rand(1..10)), mileage_total: BigDecimal(rand(1..10)), 
			hours: Run.return_random_hours, minutes: Run.return_random_minutes, seconds: Run.return_random_seconds, 
			pace: Run.return_random_pace, elevation_gain: Run.return_random_elevation_gain, city: city, completed_run: completed_run, active_run: active_run, 
			gear_id: gear_id).find_or_create_by(user_id: user_id, start_time: start_time, monthly_total_id: monthly_total_id, state_id: state_id, run_type_id: run_type_id)
	end

	### CREATE PLANNED RUN ###
	def self.create_planned_run_record(start_time, planned_mileage, gear_id, city, state_id, monthly_total_id, user_id)
		Run.create_with(name: "Planned Run", hours: 0, minutes: 0, seconds: 0, pace: "0:00", city: city, gear_id: gear_id, 
			planned_mileage: BigDecimal(planned_mileage), elevation_gain: BigDecimal('0'), state_id: state_id, completed_run: false, 
			active_run: true).find_or_create_by(user_id: user_id, start_time: start_time, monthly_total_id: monthly_total_id, state_id: state_id, run_type_id: RunType.return_planned_run_type.id)
	end

	def update_planned_run_record
		mileage_total = BigDecimal(rand(1..10))
		self.update_columns(name: "Run", start_time: self.start_time.change(hour: rand(8..13), minute: rand(0..60), second: rand(0..60)), 
			planned_mileage: BigDecimal(rand(1..10)), mileage_total: mileage_total, 
			hours: Run.return_random_hours, minutes: Run.return_random_minutes, seconds: Run.return_random_seconds, 
			pace: Run.return_random_pace, elevation_gain: Run.return_random_elevation_gain, city: "Los Angeles", completed_run: true, active_run: true, 
			gear_id: Gear.return_random_gear_id, state_id: State.find_by_abbr("CA").id, run_type_id: RunType.return_planned_run_type.id)

		#Shoe
		self.gear.add_mileage_to_shoe(mileage_total)

		#Weekly
		self.user.weekly_totals.return_newest_weekly_total.add_to_current_weekly_total(self)

		#Monthly
		self.monthly_total.add_to_monthly_total(self)

		#Yearly
		self.monthly_total.yearly_total.add_to_yearly_total(self)

		#All Time
		self.user.all_time_total.add_to_all_time_total(self)
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
			start_time = run.start_time+1.week
			monthly_total_id = MonthlyTotal.of_month(start_time).id
			@run = Run.find_or_create_by(name: run.name, start_time: start_time,
										hours: BigDecimal('0'), minutes: BigDecimal('0'), seconds: BigDecimal('0'), pace: "0:00", city: run.city,
										gear_id: default_shoe_id, planned_mileage: run.planned_mileage,
										elevation_gain: BigDecimal('0'), state_id: run.state_id, run_type_id: default_run_type_id,
										user_id: current_user.id, monthly_total_id: monthly_total_id, completed_run: false, active_run: false)
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
			start_time = run.start_time+1.week
			monthly_total_id = MonthlyTotal.of_month(start_time).id
			@run = Run.find_or_create_by(name: run.name, start_time: start_time,
										hours: BigDecimal('0'), minutes: BigDecimal('0'), seconds: BigDecimal('0'), pace: "0:00", city: run.city,
										gear_id: default_shoe_id, planned_mileage: run.planned_mileage,
										elevation_gain: BigDecimal('0'), state_id: run.state_id, run_type_id: run.run_type.id,
										user_id: current_user.id, monthly_total_id: monthly_total_id, completed_run: false, active_run: false)
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def self.copy_until_specific_date(current_user, end_week_date)
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
		end_week_start_date = end_week_date.beginning_of_week

		default_shoe_id = Gear.return_default_shoe.id

		number_of_weeks = end_week_start_date.cweek - next_week_start_date.cweek

		@current_weeks_runs = current_user.runs.where(:start_time => current_week_start_date..current_week_end_date)

		@current_weeks_runs.each do |run|
			if number_of_weeks > 0
				(1..number_of_weeks+1).each do |number|
					running_date = run.start_time + number.week

					@run = Run.find_or_create_by(name: run.name, start_time: running_date,
											hours: BigDecimal('0'), minutes: BigDecimal('0'), seconds: BigDecimal('0'), pace: "0:00", city: run.city,
											gear_id: default_shoe_id, planned_mileage: run.planned_mileage,
											elevation_gain: BigDecimal('0'), state_id: run.state_id, run_type_id: run.run_type.id,
											user_id: current_user.id, monthly_total_id: monthly_total_id, completed_run: false, active_run: false)
				end
			end
		end
	end
end
