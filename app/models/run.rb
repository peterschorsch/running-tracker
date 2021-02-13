class Run < ApplicationRecord
	extend Modules::Race
	extend FormPopulateRunField

	belongs_to :user
	belongs_to :run_type
	belongs_to :shoe
	belongs_to :monthly_total
	belongs_to :state, optional: true
	belongs_to :country
	
	before_save :set_start_time, :set_blank_notes_field, :set_corresponding_monthly_total_id
	before_update :subract_mileage_shoe
	after_save :update_subsequent_tables
	after_destroy :update_subsequent_tables

	validates :name, :start_time, :mileage_total, :pace_minutes, :pace_seconds, :time_in_seconds, :elevation_gain, :city, presence: true
	validates :mileage_total, :elevation_gain, :time_in_seconds, numericality: true
	validates :pace_minutes, :pace_seconds, length: { maximum: 2 }

	attr_accessor :hours, :minutes, :seconds

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

	# See if any runs are present on a given day
	# Returns true if there are no runs on date
	# Returns false if there are runs on date
	def self.are_runs_not_present_on_day?(run_date = Date.current)
		self.of_day(run_date).empty?
	end

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
		where("start_time <= ?", Date.current).return_uncompleted_runs
	}
	scope :return_future_uncompleted_runs, -> {
		where("start_time >= ?", Date.current).return_uncompleted_runs
	}

	scope :return_past_uncompleted_runs_except_for_current_month, -> {
		where("start_time <= ?", (Date.current-1.month).end_of_month).return_uncompleted_runs
	}

	scope :order_by_most_recent, -> {
		order('start_time DESC')
	}

	scope :order_by_oldest, -> {
		order('start_time ASC')
	}

	scope :order_by_fastest, -> {
		order('time_in_seconds ASC')
	}

	scope :order_by_runtype, -> {
		order('run_type_id ASC')
	}

	# Used on Current User's Runs
	# Finds next uncompleted run
	def self.find_next_uncompleted_run
		return_future_uncompleted_runs.first || nil
	end

	def self.find_last_completed_run
		completed_runs.order_by_most_recent.first || nil
	end

	def was_completed?
		self.completed_run
	end

	def can_be_modified?
		!self.was_completed? || !self.monthly_total.is_frozen?
	end

	def disable_run_form?
		!can_be_modified?
	end

	### FOR RUN FORMS - DETERMINE IF USER CAN MODIFY RUN RECORD - FROZEN MONTHLY TOTAL ###
	def determine_run_modification_by_user_role
		self.user.is_viewer? ? true : disable_run_form?
	end

	def is_event?
		self.event_flag
	end

	def hex_code
		self.run_type.hex_code
	end

	## CALL THIS METHOD WHEN CREATING?/UPDATING RUN IN CONTROLLER ###
	def set_necessary_run_fields(user, time_hours, time_minutes, time_seconds)
		self.user_id = user.id
		self.set_corresponding_monthly_total_id
		### Convert and set hours, minutes, seconds to just seconds ###
		self.set_time_in_seconds(time_hours, time_minutes,time_seconds)
	end

	### UPDATE RELATED TABLES THAT DEPEND ON A SINGULAR RUN ###
	def update_subsequent_tables
		if self.was_completed?
			@user = self.user
			@shoe = self.shoe
			start_date = self.start_time.to_date

			### Update Shoe Mileage Total ###
			@shoe.recalculate_new_mileage_singlular_shoe

			### RECALCULATE ALL Total Records Except all Shoes ###
			@user.recalculate_user_all_time_total

			### RECALCULATE YEARLY TOTAL RECORD ###
			@yearly_total = @user.yearly_totals.of_year(start_date)
			@yearly_total = YearlyTotal.create_zero_totals(@user.id, @user.all_time_total.id, start_date.year) if @yearly_total.nil?
			@yearly_total.recalculate_yearly_total unless @yearly_total.is_frozen?

			### RECALCULATE MONTHLY TOTAL RECORD ###
			@monthly_total = @user.monthly_totals.of_month(start_date)
			@monthly_total = MonthlyTotal.create_zero_totals(@user.id, @yearly_total.id, start_date.beginning_of_month, start_date.end_of_month) if @monthly_total.nil?
			@monthly_total.recalculate_monthly_total unless @monthly_total.is_frozen?

			### RECALCULATE WEEKLY TOTAL RECORD IF IT EXISTS ###
			@weekly_total = @user.weekly_totals.of_week(start_date)
			@weekly_total.recalculate_weekly_total if not @weekly_total.nil?
		end
	end

	### CREATE RANDOM COMPLETED RUN ###
	def self.create_random_run_record(name, start_time, completed_run, shoe_id, city, state_id, country_id, run_type_id, monthly_total_id, user_id)
		Run.create_with(name: name, planned_mileage: Run.return_random_mileage, mileage_total: Run.return_random_mileage, time_in_seconds: Run.return_random_time_in_seconds, 
			pace_minutes: Run.return_random_pace_minutes, pace_seconds: Run.return_random_pace_seconds, elevation_gain: Run.return_random_elevation_gain, city: city, completed_run: completed_run, 
			shoe_id: shoe_id).find_or_create_by(user_id: user_id, start_time: start_time, monthly_total_id: monthly_total_id, state_id: state_id,  country_id: country_id, run_type_id: run_type_id)
	end

	### CREATE PLANNED RUN ###
	def self.create_planned_run_record(start_time, planned_mileage, shoe_id, city, state_id, country_id, monthly_total_id, user_id)
		Run.create_with(name: "Planned Run", time_in_seconds: 0, pace_minutes: "0", pace_seconds: "00", city: city, shoe_id: shoe_id, 
			planned_mileage: BigDecimal(planned_mileage), elevation_gain: BigDecimal('0'), state_id: state_id, 
			completed_run: false).find_or_create_by(user_id: user_id, start_time: start_time, monthly_total_id: monthly_total_id, state_id: state_id,  country_id: country_id, run_type_id: RunType.return_planned_run_type.id)
	end

	### CREATE BLANK RUN WITH A PROVIDED NAME ###
	def self.create_blank_run_record(name, start_time, planned_mileage, shoe_id, city, state_id, country_id, monthly_total_id, user_id)
		Run.create_with(name: name, time_in_seconds: 0, pace_minutes: "0", pace_seconds: "00", city: city, shoe_id: shoe_id, 
			planned_mileage: BigDecimal(planned_mileage), elevation_gain: BigDecimal('0'), state_id: state_id, 
			completed_run: false).find_or_create_by(user_id: user_id, start_time: start_time, monthly_total_id: monthly_total_id, state_id: state_id, country_id: country_id, run_type_id: RunType.return_planned_run_type.id)
	end

	### FOR WEBSITE VIEWER TO UPDATE PLANNED RUNS BETWEEN LAST LOGIN AND CURRENT LOGIN DATE ###
	def update_planned_run_record
		self.update_columns(name: self.user.concat_user_default_city_run_name, start_time: Run.return_random_run_start_time(self.start_time),
			planned_mileage: Run.return_random_mileage, mileage_total: Run.return_random_mileage, time_in_seconds: Run.return_random_time_in_seconds, 
			pace_minutes: Run.return_random_pace_minutes, pace_seconds: Run.return_random_pace_seconds, elevation_gain: Run.return_random_elevation_gain, city: self.user.default_city, completed_run: true, 
			shoe_id: self.user.shoes.return_random_shoe.id, state_id: State.find_by_name(self.user.default_state).id, country_id: Country.find_by_name(self.user.default_country).id, run_type_id: RunType.return_planned_run_type.id)
	end

	### RETURNS RUNS FROM LAST 7 DAYS IF NO ARGUMENTS ARE PASSED ###
	def self.retrieve_specific_runs(starting_day = DateTime.current.change(hour: 0)-7.days, ending_day = DateTime.current.end_of_day)
		Run.where(start_time: starting_day..ending_day)
	end


	### COPY LAST WEEK'S RUNS TO CURRENT WEEK ###
	def self.copy_last_weeks_runs(user)
		# Last week's Date
		last_week_date = DateTime.current-1.week
		# Starts on a Monday
		week_start_date = last_week_date.beginning_of_week
		week_end_date = last_week_date.end_of_week

		@last_weeks_runs = user.runs.where(:start_time => week_start_date..week_end_date)
		@last_weeks_runs.each do |run|
			start_time = run.start_time+1.week
			user.create_future_yearly_monthly_total(start_time) # Creates Monthly and Yearly Total if it doesn't existing (depending on start_time)
			monthly_total_id = user.monthly_totals.of_month(start_time).id

			Run.create_blank_run_record(run.name, start_time, run.planned_mileage, user.shoes.return_default_shoe.id, run.city, run.state_id, run.country_id, monthly_total_id, user.id)
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK ###
	def self.copy_current_weeks_runs(user)
		# Current week's Date
		current_week_date = DateTime.current
		# Starts on a Monday
		current_start_date = current_week_date.beginning_of_week
		current_end_date = current_week_date.end_of_week

		@current_weeks_runs = user.runs.where(:start_time => current_start_date..current_end_date)
		@current_weeks_runs.each do |run|
			start_time = run.start_time+1.week
			user.create_future_yearly_monthly_total(start_time) # Creates Monthly and Yearly Total if it doesn't existing (depending on start_time)
			monthly_total_id = user.monthly_totals.of_month(start_time).id

			Run.create_blank_run_record(run.name, start_time, run.planned_mileage, user.shoes.return_default_shoe.id, run.city, run.state_id, run.country_id, monthly_total_id, user.id)
		end
	end

	### COPY LAST WEEK'S RUNS TO CURRENT WEEK ###
	def self.copy_until_specific_date(user, end_week_date)
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

		number_of_weeks = end_week_start_date.cweek - next_week_start_date.cweek
		@current_weeks_runs = user.runs.where(:start_time => current_week_start_date..current_week_end_date)

		@current_weeks_runs.each do |run|
			if number_of_weeks > 0
				(1..number_of_weeks+1).each do |number|
					running_date = run.start_time + number.week
					user.create_future_yearly_monthly_total(running_date) # Creates Monthly and Yearly Total if it doesn't existing (depending on start_time)
					monthly_total_id = user.monthly_totals.of_month(running_date).id

					Run.create_blank_run_record(run.name, running_date, run.planned_mileage, user.shoes.return_default_shoe.id, run.city, run.state_id, run.country_id, monthly_total_id, user.id)
				end
			end
		end
	end

	def form_convert_elapsed_time(hours=0, minutes=0, seconds=0)
		(hours.to_i*60*60) + (minutes.to_i*60) + seconds.to_i
	end

	private
	def set_start_time
		self.start_time = self.start_time.utc
	end

	def set_blank_notes_field
		self.notes = nil if self.notes == ""
	end

	def subract_mileage_shoe
		@old_shoe = self.user.shoes.find(self.shoe_id_was)
		@old_shoe.subract_mileage_from_shoe(self.mileage_total)
	end


	protected
	def set_time_in_seconds(hours, minutes, seconds)
		self.time_in_seconds = self.form_convert_elapsed_time(hours, minutes, seconds) unless hours.to_i == 0 && minutes.to_i == 0 && seconds.to_i == 0
	end

	### SETS MONTHLY TOTAL ID DEPENDING ON START TIME ###
	### CREATES NEW MONTHLY TOTAL IF NEEDDED ###
	def set_corresponding_monthly_total_id
		start_date = self.start_time.to_date
		user = self.user
		@monthly_total = user.monthly_totals.of_month(start_date)

		if @monthly_total.nil?
			@yearly_total = YearlyTotal.create_zero_totals(user.id, user.all_time_total.id, start_date)
			@monthly_total = MonthlyTotal.create_zero_totals(user.id, @yearly_total.id, start_date.beginning_of_month, start_date.end_of_month)
		end

		self.monthly_total_id = @monthly_total.id
	end

end
