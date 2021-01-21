class Obligation < ApplicationRecord
	belongs_to :state
	belongs_to :user
	belongs_to :obligation_color

	before_save :set_start_time

	validates :name, :start_time, :city, presence: true

	scope :order_by_newest_date_time, -> {
		order('start_time DESC, end_time ASC')
	}

	scope :order_by_oldest_date_time, -> {
		order(:start_time, :end_time)
	}

	scope :return_obligations_past_week, -> {
		where(start_time: (DateTime.current-1.week).beginning_of_day..DateTime.current)
	}

	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :of_day, -> (date = DateTime.current) {
		where(:start_time => date.beginning_of_day..date.end_of_day)
	}

	def is_end_time_nil?
		self.end_time.nil?
	end

	# Chicago, IL
	def concat_city_state
		self.city + ", " + self.state.abbreviation
	end

	# Chicago, Illinois
	def concat_city_state_name
		self.city + ", " + self.state.name
	end

	def is_event?
		self.event_flag
	end

	def hex_code
		self.obligation_color.hex_code
	end

	### PICK RANDOM RECORD FROM OBLIGATION DATA ###
	def self.get_random_obligation(random_datetime_of_week)
		Obligation.obligation_data(random_datetime_of_week).sample
	end

	private
	def set_start_time
		self.start_time = self.start_time.utc
		self.end_time = self.end_time.utc if not self.end_time.nil?
	end

	protected
	def self.obligation_data(random_datetime_of_week)
		pacific_time_zone = random_datetime_of_week.in_time_zone("Pacific Time (US & Canada)")
		central_time_zone = random_datetime_of_week.in_time_zone("Central Time (US & Canada)")
		eastern_time_zone = random_datetime_of_week.in_time_zone("Eastern Time (US & Canada)")

		return data = [
			# NAME, STARTTIME, ENDTIME, CITY, STATE ABBREVIATION #
			["Attend Wedding", eastern_time_zone.change(hour: 16, minute: 0, second: 0), eastern_time_zone.change(hour: 22, minute: 0, second: 0), "Miami", "FL"],
			["Attend Meeting", central_time_zone.change(hour: 14, minute: 30, second: 0), central_time_zone.change(hour: 15, minute: 0, second: 0), "Chicago", "IL"],
			["Go to Grocery Store", pacific_time_zone.change(hour: 10, minute: 15, second: 0), nil, "Los Angeles", "CA"] ,
			["Go to Birthday Party", pacific_time_zone.change(hour: 14, minute: 0, second: 0), pacific_time_zone.change(hour: 18, minute: 0, second: 0), "Los Angeles", "CA"],
			["Workout Class", pacific_time_zone.change(hour: 18, minute: 30, second: 0), nil, "Los Angeles", "CA"],
			["Do Laundry", pacific_time_zone.change(hour: 13, minute: 0, second: 0), nil, "Los Angeles", "CA"]
		]
	end
end
