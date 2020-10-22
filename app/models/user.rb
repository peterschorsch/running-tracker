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
		@monthly_total = MonthlyTotal.create_random_totals(self.id, @yearly_total.id, Date.current.beginning_of_month, Date.current.end_of_month)

		### Create Weekly Totals if not yet currently created ###
		@weekly_total = WeeklyTotal.create_random_totals(self.id)
	end


	### DISPLAY METHODS ###
	def concat_name
		self.first_name + " " + self.last_name
	end
end
