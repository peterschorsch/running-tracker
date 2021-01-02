class User < ApplicationRecord
	has_one :all_time_total, dependent: :destroy
	has_many :yearly_totals, dependent: :destroy
	has_many :monthly_totals, dependent: :destroy
	has_many :weekly_totals, dependent: :destroy
	has_many :gears, dependent: :destroy
	has_many :runs, dependent: :destroy
	has_many :obligations, dependent: :destroy

	include EmailValidator

	validates :first_name, :last_name, presence: true
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
		where.not(:role => "Viewer")
	}

	def self.return_website_viewer
		User.find_user_by_name("Website","Viewer")
	end


	### DISPLAY METHODS ###
	def concat_name
		self.first_name + " " + self.last_name
	end

	def is_admin?
		self.role == "Admin"
	end

	def is_user?
		self.role == "User"
	end

	def is_viewer?
		self.role == "Viewer"
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

	### GET RUNS OF CURRENT WEEK ###
	def current_runs_of_week
		runs.of_week
	end

	### GET CURRENT WEEKLY TOTAL ###
	def current_weekly_total
		weekly_totals.of_week
	end

	### GET CURRENT MONTHLY TOTAL ###
	def current_monthly_total
		monthly_totals.of_month
	end

	### GET CURRENT YEARLY TOTAL ###
	def current_yearly_total
		yearly_totals.of_year
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	### LOGIN METHODS - CHECKS FOR ALL APPROPRIATE TOTAL RECORDS FOR NORMAL AND ADMIN USERS ###
	### ALL-TIME TOTAL, YEARLY TOTAL, MONTHLY TOTAL RECORDS ###
	def check_for_total_records_upon_login
		self.check_for_all_time_total_record
		self.check_for_current_yearly_total_record
		self.check_for_current_monthly_total_record
		self.check_for_current_weekly_total_record
	end

	### CHECK IF USER HAS AN ALL TIME TOTAL RECORD ###
	def check_for_all_time_total_record
		AllTimeTotal.create_with(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0).find_or_create_by(user_id: self.id)
	end

	### CHECK IF USER HAS AN YEARLY TOTAL RECORD ###
	def check_for_current_yearly_total_record
		YearlyTotal.create_with(year_start: DateTime.now.beginning_of_year, year_end: DateTime.now.end_of_year, mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0).find_or_create_by(year: Date.current.year, all_time_total_id: self.all_time_total.id, user_id: self.id)
	end

	### CHECK IF USER HAS AN MONTHLY TOTAL RECORD ###
	def check_for_current_monthly_total_record
		MonthlyTotal.create_zero_totals(self.id, self.current_yearly_total.id, DateTime.now.beginning_of_month, DateTime.now.end_of_month)
	end

	### CHECK IF USER HAS A CURRENT WEEKLY TOTAL RECORD ###
	def check_for_current_weekly_total_record
		@weekly_totals = self.weekly_totals
		if @weekly_totals.empty?
			if not self.is_viewer?
				WeeklyTotal.create_four_blank_weekly_totals(self.id)
			else
				WeeklyTotal.create_four_random_weekly_totals(self.id)
			end
		else
			if @weekly_totals.of_week.nil?
				current_date = Date.current
				@oldest_weekly_total = @weekly_totals.return_oldest_weekly_total

				if not self.is_viewer?
					# Update oldest weekly run totals to zero and change date to current week
					@oldest_weekly_total.update_zeroed_weekly_total_record(current_date.beginning_of_week, current_date.end_of_week)
				else
					# Update oldest weekly run totals to random numbers and change date to current week
					@oldest_weekly_total.update_random_weekly_total_record(current_date.beginning_of_week, current_date.end_of_week)
				end
			end
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
		current_date = Date.current
		end_of_week = current_date.end_of_week

		gear_id = Gear.return_default_shoe.id
		city = "Los Angeles"
		state_id = State.find_by_abbr("CA").id

		### CREATE RUNS FROM LAST RUN TO CURRENT DAY ###
		(@last_run_start_time..current_date-1.day).each do |date|
			run_type_id = RunType.return_random_run_type_id
			@monthly_total = self.monthly_totals.of_month(date)

			Run.create_random_run_record("Run", Run.return_random_run_start_time(date), true, true, gear_id, city, state_id, run_type_id, @monthly_total.id, self.id)
			self.refresh_all_user_totals
		end

		### CREATE PLANNED RUNS FROM CURRENT DAY TO END OF WEEK  ###
		self.create_weeklong_default_runs
	end

	### WEBSITE VIEWER - MAKE NECESSARY OBLIGATIONS FOR PAST WEEK IF NEEDED ###
	def check_for_recent_obligations
		if self.obligations.return_obligations_past_week.count < 2
			random_obligation_data = Obligation.get_random_obligation
			Obligation.find_or_create_by(name: random_obligation_data[0], start_time: random_obligation_data[1], end_time: random_obligation_data[2], city: random_obligation_data[3], state_id: State.find_by_abbr(random_obligation_data[4]).id, user_id: self.id, obligation_color_id: ObligationColor.default_record.id)
		end
	end

	### CREATE DEFAULT RUNS FOR CURRENT WEEK ###
	def create_weeklong_default_runs
		default_shoe_id = Gear.return_default_shoe.id
		state_id = State.find_by_abbr("CA").id
		run_type_id = RunType.default_run_type.id

		# Current Date
		current_date = DateTime.now
		# Starts on a Monday
		week_start_date = current_date.beginning_of_week
		week_end_date = current_date.end_of_week
		loop_week = week_start_date...week_end_date

		loop_week.each do |date|
			@existing_run = self.runs.of_day(date)

			if @existing_run.empty?
				@monthly_total = self.current_monthly_total
				@run = Run.create_planned_run_record(date, rand(1..20), default_shoe_id, "Los Angeles", state_id, @monthly_total.id, self.id)
			end
		end
	end

	def refresh_all_user_totals
		WeeklyTotal.refresh_weekly_totals(self)
		MonthlyTotal.refresh_monthly_totals(self)
		YearlyTotal.refresh_yearly_totals(self)
		AllTimeTotal.refresh_all_time_total(self)

		Gear.recalculate_mileage_of_shoe(self)
	end
end
