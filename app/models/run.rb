class Run < ApplicationRecord
	belongs_to :user
	belongs_to :monthly_total
	belongs_to :shoe
	belongs_to :state
	belongs_to :run_type

	before_save :set_start_time
	after_save :update_subsequent_tables

	validates :name, :start_time, :mileage_total, :time_in_seconds, :elevation_gain, :city, presence: true
	validates :mileage_total, :elevation_gain, numericality: true
	validates :time_in_seconds, numericality: true
	attr_accessor :hours, :minutes, :seconds

	def form_convert_elapsed_time(hours=0, minutes=0, seconds=0)
		(hours.to_i*60*60) + (minutes.to_i*60) + seconds.to_i
	end

	def form_convert_and_save_elapsed_time(hours=0, minutes=0, seconds=0)
		elapsed_time = self.form_convert_elapsed_time(hours, minutes, seconds)
		self.update_columns(:time_in_seconds => elapsed_time)
	end

	def set_time_in_seconds(hours, minutes, seconds)
		self.time_in_seconds = self.form_convert_elapsed_time(hours, minutes, seconds) unless hours.to_i == 0 && minutes.to_i == 0 && seconds.to_i == 0
	end

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

	scope :of_week, -> (week = Date.current) {
	    where(start_time: week.beginning_of_week..week.end_of_week)
	}

	scope :of_month, -> (month = Date.current) {
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

	scope :completed_runs, -> {
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
		order('time_in_seconds ASC')
	}

	### RACE RELATED SCOPES & METHODS ###
	scope :return_races, -> {
		joins(:run_type).where("run_types.name=?", "Race").completed_runs
	}

	scope :retrieve_personal_bests, -> {
		return_races.where("runs.personal_best=?", true).order(:mileage_total).includes(:state)
	}

	scope :return_5k_results, -> {
		where(mileage_total: BigDecimal('3.1')).completed_runs
	}

	scope :return_10k_results, -> {
		where(mileage_total: BigDecimal('6.2')).completed_runs
	}

	scope :return_half_marathon_results, -> {
		where(mileage_total: BigDecimal('13.1')).completed_runs
	}

	scope :return_marathon_results, -> {
		where(mileage_total: BigDecimal('26.2')).completed_runs
	}

	def self.return_race_distance_counts
		totals = self.group(:mileage_total).count
		mappings = { BigDecimal('3.1') => '5K', BigDecimal('6.2') => '10K', BigDecimal('13.1') => 'Half Marathon', BigDecimal('26.2') => 'Marathon' }
		return totals.transform_keys(&mappings.method(:[]))
	end
	### END OF RACE RELATED SCOPES & METHODS ###

	# Used on Current User's Runs
	# Finds next uncompleted run
	def self.find_next_uncompleted_run
		return_uncompleted_runs.find_by("start_time >= ?", DateTime.current.beginning_of_day..DateTime.current.end_of_day) || nil
	end

	def self.find_last_completed_run
		completed_runs.order_by_most_recent.first || nil
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
		DateTime.new(date.year, date.month, date.day, rand(14..15), [0,30].sample, 0).localtime
	end

	def self.return_planned_run_start_time(date = Date.current)
		DateTime.new(date.year, date.month, date.day, 16, 0, 0).localtime
	end

	def make_run_inactive
		self.active_run = false
		self.save(:validate => false)
	end

	def hex_code
		self.run_type.hex_code
	end

	def self.return_random_mileage
		BigDecimal(rand(1..10))
	end

	def self.return_random_pace
		rand(6..10).to_s + ":" + rand(0..59).to_s.rjust(2, '0')
	end

	def self.return_random_seconds
		rand(21600..115200)
	end

	def self.return_random_elevation_gain
		BigDecimal(rand(50..1000))
	end

	### UPDATE RELATED TABLES THAT DEPEND ON RUN ###
	def update_subsequent_tables
		if self.was_completed?
			### Update Shoe Mileage Total - FIX ###
			#@run.shoe.recalculate_mileage_of_shoes(params[:run][:mileage_total].to_f)

			self.update_weekly_total

			### Update Monthly Total ###
			self.monthly_total.update_monthly_total

			### Update Yearly Total ###
			self.monthly_total.yearly_total.update_yearly_total

			### Update All Time Total ###
			self.user.all_time_total.update_all_time_total
		end
	end

	### UPDATE WEEKLY TOTAL WITH RUN TOTALS IF IT EXISTS ###
	### CALLED AFTER A RUN IS UPDATED IN CALENDAR OR RUNS TABLE ###
	def update_weekly_total
		@weekly_total = self.user.weekly_totals.of_week(self.start_time)

		# Find out if run falls within one of the four weekly total records time frame. If so, update the weekly total record
		if not @weekly_total.nil?
			@runs = self.user.return_completed_runs.of_week(self.start_time)
			mileage_total = @runs.sum(:mileage_total)
			@weekly_total.update_columns(:mileage_total => mileage_total, :met_goal => mileage_total>=@weekly_total.mileage_goal, :time_in_seconds => @runs.sum(:time_in_seconds), :number_of_runs => @runs.count, :elevation_gain => @runs.sum(:elevation_gain))
		end
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
		total_record.mileage_total = 

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
	def self.create_random_run_record(name, start_time, completed_run, active_run, shoe_id, city, state_id, run_type_id, monthly_total_id, user_id)
		Run.create_with(name: name, planned_mileage: Run.return_random_mileage, mileage_total: Run.return_random_mileage, time_in_seconds: Run.return_random_seconds, 
			pace: Run.return_random_pace, elevation_gain: Run.return_random_elevation_gain, city: city, completed_run: completed_run, active_run: active_run, 
			shoe_id: shoe_id).find_or_create_by(user_id: user_id, start_time: start_time, monthly_total_id: monthly_total_id, state_id: state_id, run_type_id: run_type_id)
	end

	### CREATE PLANNED RUN ###
	def self.create_planned_run_record(start_time, planned_mileage, shoe_id, city, state_id, monthly_total_id, user_id)
		Run.create_with(name: "Planned Run", time_in_seconds: 0, pace: "0:00", city: city, shoe_id: shoe_id, 
			planned_mileage: BigDecimal(planned_mileage), elevation_gain: BigDecimal('0'), state_id: state_id, completed_run: false, 
			active_run: true).find_or_create_by(user_id: user_id, start_time: start_time, monthly_total_id: monthly_total_id, state_id: state_id, run_type_id: RunType.return_planned_run_type.id)
	end

	### CREATE BLANK RUN WITH A PROVIDED NAME ###
	def self.create_blank_run_record(name, start_time, planned_mileage, shoe_id, city, state_id, monthly_total_id, user_id)
		Run.create_with(name: name, time_in_seconds: 0, pace: "0:00", city: city, shoe_id: shoe_id, 
			planned_mileage: BigDecimal(planned_mileage), elevation_gain: BigDecimal('0'), state_id: state_id, completed_run: false, 
			active_run: true).find_or_create_by(user_id: user_id, start_time: start_time, monthly_total_id: monthly_total_id, state_id: state_id, run_type_id: RunType.return_planned_run_type.id)
	end

	def update_planned_run_record
		mileage_total = Run.return_random_mileage

		self.update_columns(name: "Run", start_time: Run.return_random_run_start_time(self.start_time), 
			planned_mileage: Run.return_random_mileage, mileage_total: mileage_total, time_in_seconds: Run.return_random_seconds, 
			pace: Run.return_random_pace, elevation_gain: Run.return_random_elevation_gain, city: "Los Angeles", completed_run: true, active_run: true, 
			shoe_id: Shoe.return_default_shoe.id, state_id: State.find_by_abbr("CA").id, run_type_id: RunType.return_planned_run_type.id)

		#Shoe
		self.shoe.add_mileage_to_shoe(mileage_total)

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
	def self.retrieve_specific_runs(starting_day = DateTime.current.change(hour: 0)-7.days, ending_day = DateTime.current.end_of_day)
		Run.where(start_time: starting_day..ending_day)
	end


	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def self.copy_last_weeks_runs(current_user)
		# Last week's Date
		last_week_date = DateTime.current-1.week
		# Starts on a Monday
		week_start_date = last_week_date.beginning_of_week
		week_end_date = last_week_date.end_of_week

		default_shoe_id = Gear.return_default_shoe.id
		default_run_type_id = RunType.default_run_type.id

		@last_weeks_runs = current_user.runs.where(:start_time => week_start_date..week_end_date)
		@last_weeks_runs.each do |run|
			start_time = run.start_time+1.week
			monthly_total_id = MonthlyTotal.of_month(start_time).id

			Run.create_blank_run_record(run.name, start_time, run.planned_mileage, default_shoe_id, run.city, run.state_id, monthly_total_id, current_user.id)
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def self.copy_current_weeks_runs(current_user)
		# Current week's Date
		current_week_date = DateTime.current
		# Starts on a Monday
		current_start_date = current_week_date.beginning_of_week
		current_end_date = current_week_date.end_of_week

		default_shoe_id = Gear.return_default_shoe.id

		@current_weeks_runs = Run.of_user(current_user).where(:start_time => current_start_date..current_end_date)
		@current_weeks_runs.each do |run|
			start_time = run.start_time+1.week
			monthly_total_id = MonthlyTotal.of_month(start_time).id

			Run.create_blank_run_record(run.name, start_time, run.planned_mileage, default_shoe_id, run.city, run.state_id, monthly_total_id, current_user.id)
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK
	def self.copy_until_specific_date(current_user, end_week_date)
		# Current Week's Date
		current_week_date = DateTime.current
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

					Run.create_blank_run_record(run.name, running_date, run.planned_mileage, default_shoe_id, run.city, run.state_id, monthly_total_id, current_user.id)
				end
			end
		end
	end

	private
	def set_start_time
		self.start_time = self.start_time.utc
	end
end
