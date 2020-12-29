class User < ApplicationRecord
	has_one :all_time_total, dependent: :destroy
	has_many :yearly_totals, dependent: :destroy
	has_many :monthly_totals, dependent: :destroy
	has_many :weekly_totals, dependent: :destroy
	has_many :gears, dependent: :destroy
	has_many :runs, dependent: :destroy

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

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
	                                                BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	### FOR TESTING ###
	def create_user_totals
		### Create All Time Total if not yet currently created ###
		@all_time_total = AllTimeTotal.create_random_totals(self.id)

		### Create Yearly Totals if not yet currently created ###
		@yearly_total = YearlyTotal.create_random_totals(self.id, @all_time_total.id)

		### Create Monthly Totals if not yet currently created ###
		@monthly_total = MonthlyTotal.create_random_totals(self.id, @yearly_total.id, Date.current.beginning_of_month, Date.current.end_of_month) if MonthlyTotal.of_month.nil?

		### Create Weekly Totals if not yet currently created ###
		@weekly_total = WeeklyTotal.create_random_totals(self.id)
	end

	### CHECK IF USER HAS A CURRENT WEEKLY TOTAL ###
	def check_current_weekly_total_record_upon_login
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

	### CREATE RUNS FOR WEBSITE VIEWER WHEN THEY LOGIN ###
	def create_website_viewer_runs
		### UPDATE PREVIOUSLY UNCOMPLETED RUNS ###
		self.runs.return_past_uncompleted_runs do |uncompleted_run|
			uncompleted_run.name = "Run"
			uncompleted_run.start_time = Run.return_random_run_start_time(uncompleted_run.start_time)
			uncompleted_run.planned_mileage = rand(2..20)
			uncompleted_run.mileage_total = rand(2..20)
			uncompleted_run.pace = Run.return_random_pace
			uncompleted_run.hours = Run.return_random_hours
			uncompleted_run.minutes = Run.return_random_minutes
			uncompleted_run.seconds = Run.return_random_seconds
			uncompleted_run.elevation_gain = Run.return_random_elevation_gain
			uncompleted_run.completed_run = true
			uncompleted_run.run_type_id = RunType.return_random_run_type_id
			uncompleted_run.gear_id = Gear.return_random_gear_id
			uncompleted_run.save(:validate => false)
		end

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

	def check_past_planned_runs
		self.runs.return_past_uncompleted_runs.each { |run| run.update_planned_run_record }
	end

	### CREATE DEFAULT RUNS FOR CURRENT WEEK
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
				@monthly_total = self.monthly_totals.of_month
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

	def self.return_website_viewer
		User.find_user_by_name("Website","Viewer")
	end


	### DISPLAY METHODS ###
	def concat_name
		self.first_name + " " + self.last_name
	end

	def auto_timeout
		1.minute
		#15.minutes
	end
end
