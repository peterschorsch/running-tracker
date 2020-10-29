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

		loop_week.each_with_index do |date, index|
			@existing_run = Run.of_day(date)

			if not @existing_run.exists?
				@run = Run.find_or_create_by(name: "Planned Run #{index+1}", start_time: date,
											hours: 0, minutes: 0, seconds: 0, pace: "0:00", city: "Los Angeles",
											gear_id: default_shoe_id, planned_mileage: BigDecimal('0'),
											elevation_gain: BigDecimal('0'), state_id: state_id, run_type_id: run_type_id,
											user_id: self.id, completed_run: false)
			end
		end
	end


	### DISPLAY METHODS ###
	def concat_name
		self.first_name + " " + self.last_name
	end
end
