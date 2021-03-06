class User < ApplicationRecord
	include Modules::UserTotalRecord

	belongs_to :user_role
	has_one :all_time_total, dependent: :destroy
	has_many :yearly_totals, dependent: :destroy
	has_many :monthly_totals, dependent: :destroy
	has_many :weekly_totals, dependent: :destroy
	has_many :shoes, dependent: :destroy
	has_many :runs, dependent: :destroy
	has_many :obligations, dependent: :destroy

	include EmailValidator

	validates :first_name, :last_name, :default_city, :default_state, :default_state, presence: true
	validates :email, presence: true, email: true, uniqueness: true
	has_secure_password

	PASSWORD_FORMAT = /\A
		(?=.{8,})          # Must contain 8 or more characters
		(?=.*\d)           # Must contain a digit
		(?=.*[a-z])        # Must contain a lower case character
		(?=.*[A-Z])        # Must contain an upper case character
		(?=.*[[:^alnum:]]) # Must contain a symbol
	/x

	validates :password_digest, format: PASSWORD_FORMAT

	scope :find_user_by_name, -> (firstname, lastname) {
		find_by(:first_name => firstname, :last_name => lastname)
	}

	scope :exclude_viewer_accounts, -> {
		joins(:user_role).where("user_roles.website_viewer=?", false)
	}

	def self.return_website_viewer
		User.find_user_by_name("Website","Viewer")
	end

	### DISPLAY METHODS ###
	def concat_name
		self.first_name + " " + self.last_name
	end

	### CONCATENATE USERS DEFAULT CITY WITH RUN ###
	def concat_user_default_city_run_name
		self.default_city + " Run"
	end

	def is_admin?
		self.user_role.administrator == true
	end

	def is_user?
		self.user_role.user == true
	end

	def is_viewer?
		self.user_role.website_viewer == true
	end

	def is_active?
		self.active
	end

	def is_archived?
		!self.active
	end

	def personal_best_races
		runs.retrieve_personal_bests
	end

	def update_last_login
		self.update_columns(:last_login => DateTime.current)
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	### LOGIN METHODS - CHECKS FOR ALL APPROPRIATE TOTAL RECORDS FOR NORMAL AND ADMIN USERS ###
	### ALL-TIME TOTAL, YEARLY TOTAL, MONTHLY TOTAL, WEEKLY TOTAL RECORDS ###
	def check_for_total_records_upon_login
		self.check_for_all_time_total_record
		self.check_for_current_yearly_total_record
		self.check_for_current_monthly_total_record
		self.check_for_current_weekly_total_record
		self.check_on_frozen_total_records
	end

	### CHECK IF USER HAS A CURRENT WEEKLY TOTAL RECORD ###
	def check_for_current_weekly_total_record
		@weekly_totals = self.weekly_totals

		# If all 4 weekly totals have already been created
		if not @weekly_totals.empty?
			self.weekly_totals.set_oldest_weekly_total_to_zero if self.current_weekly_total.nil?
		else
			# If 4 weekly totals have NOT already been created
			self.is_viewer? ? WeeklyTotal.create_four_random_weekly_totals(self) : WeeklyTotal.create_four_blank_weekly_totals(self)
		end
	end

	### LOGIN METHODS - CHECKS FOR ALL APPROPRIATE TOTAL RECORDS FOR WEBSTIE VIEWER ###
	### UPDATE PAST UNCOMPLETED RUNS & CREATE NEW RUNS IF NECESSARY, CREATE OBLIGATIONS IF NECESSARY ###
	def website_viewer_methods_check_upon_login
		self.update_website_viewer_runs_to_current_day
        self.check_for_recent_obligations
	end

	### CREATE RUNS FOR WEBSITE VIEWER WHEN THEY LOGIN ###
	def update_website_viewer_runs_to_current_day
		### UPDATE PREVIOUSLY UNCOMPLETED RUNS ###
		self.runs.return_past_uncompleted_runs.each { |uncompleted_run| uncompleted_run.update_planned_run_record }

		@last_run_start_time = self.runs.order_by_most_recent.first.start_time.to_date

		shoe_id = self.shoes.return_default_shoe.id
		city = self.default_city
		state_id = State.find_by_name(self.default_state).id
		country_id = Country.find_by_name(self.default_country).id

		### CREATE RUNS FROM LAST RUN TO CURRENT DAY ###
		(@last_run_start_time..Date.current-1.day).each do |date|
			if self.runs_of_current_week.count < 6
				run_type_id = RunType.return_random_run_type_id
				monthly_total_id = self.monthly_totals.of_month(date).id
				if self.runs.are_runs_not_present_on_day?(date)
					Run.create_random_run_record(self.concat_user_default_city_run_name, Run.return_random_run_start_time(date), true, shoe_id, city, state_id, country_id, run_type_id, monthly_total_id, self.id)
				end
			end
		end

		self.recalculate_all_user_totals_and_shoes

		### CREATE PLANNED RUNS FROM CURRENT DAY TO END OF WEEK  ###
		self.create_weeklong_default_runs
	end

	### WEBSITE VIEWER - MAKE NECESSARY OBLIGATIONS FOR PAST WEEK IF NEEDED ###
	def check_for_recent_obligations
		past_weeks_obligations = self.obligations.return_obligations_past_week
		if past_weeks_obligations.count <= 2

			current_datetime = DateTime.current
			current_week_start = current_datetime.beginning_of_week
			# Pick random day of week starting at beginning of current week and ending at current date day
			random_date_of_week = rand(current_week_start..current_datetime)

			if past_weeks_obligations.of_day(random_date_of_week).empty?
				random_obligation_data = Obligation.get_random_obligation(random_date_of_week)

				Obligation.find_or_create_by(name: random_obligation_data[0], start_time: random_obligation_data[1], end_time: random_obligation_data[2], city: random_obligation_data[3], state_id: State.find_by_abbr(random_obligation_data[4]).id, user_id: self.id, obligation_color_id: ObligationColor.default_record.id)
			end
		end
	end

	### DYNAMICALLY CREATES RACES FOR WEBSITE VIEWER ACCOUNT ###
	## BASED ON IF ANY RACES ARE RETURN WITHIN THE LAST TWO MONTHS ##
	def dynamically_create_website_viewer_races
		@runs = self.runs
		@races = @runs.return_races
		@recent_races = @races.of_month + @races.of_month(Date.current-1.month)

		# See if any races have occured in the past two months
		if @recent_races.empty?
			start_date = Date.current.prev_occurring(:sunday)
			@sundays_runs = @runs.of_day(start_date) # Find all runs of the previous sunday
			@sundays_runs.delete_all # Remove runs of the previous sunday

			# Create a Race
			@race_distance = RaceDistance.all.sample
			@race_example = @race_distance.race_examples.sample
			@monthly_total = self.monthly_totals.of_month(start_date)

			race_run_type = RunType.named("Race")
			shoe = self.shoes.return_random_shoe
			start_time = Run.return_random_race_start_time(start_date)

			if @runs.are_runs_not_present_on_day?(start_date)
				@race = Run.create_with(planned_mileage: @race_distance.numeric_distance, mileage_total: @race_distance.numeric_distance, 
				time_in_seconds: @race_example.time_in_seconds, pace_minutes: @race_example.pace_minutes, pace_seconds: @race_example.pace_seconds,
				elevation_gain: @race_example.elevation_gain, city: @race_example.city, completed_run: true, 
				shoe_id: shoe.id, state_id: @race_example.state_id).find_or_create_by(name: @race_example.name, start_time: start_time, run_type_id: race_run_type.id, user_id: self.id, monthly_total_id: @monthly_total.id)
			end
		end
	end

	### DESTROY PLANNED RUNS THAT ARE NOT IN CURRENT MONTH ###
	def check_for_previous_planned_runs
		self.runs.return_past_uncompleted_runs_except_for_current_month.destroy_all
	end

	### CREATE DEFAULT RUNS FOR CURRENT WEEK ###
	def create_weeklong_default_runs
		default_shoe_id = self.shoes.return_default_shoe.id
		city = self.default_city
		state_id = State.find_by_name(self.default_state).id
		country_id = Country.find_by_name(self.default_country).id
		run_type_id = RunType.default_run_type.id

		# Current Date
		current_date = Date.current
		# Starts on a Monday, Ends on a Sunday
		week_start_date = current_date.beginning_of_week
		week_end_date = current_date.end_of_week
		date_array = (week_start_date...week_end_date+1.day).to_a

		2.times { date_array.to_a.delete_at(rand(date_array.count)) } if self.is_viewer?

		date_array.each do |date|
			if self.runs.are_runs_not_present_on_day?(date)
				@monthly_total = self.current_monthly_total
				mileage = self.is_viewer? ? rand(1..20) : 0

				@run = Run.create_planned_run_record(Run.return_planned_run_start_time(date), mileage, default_shoe_id, city, state_id, country_id, @monthly_total.id, self.id)
				#puts @run.inspect
			end
		end
	end

end
