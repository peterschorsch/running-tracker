class Obligation < ApplicationRecord
	belongs_to :state
	belongs_to :user

	validates :name, :start_time, :city, presence: true

	scope :order_by_newest_date_time, -> {
		order('start_time ASC, end_time ASC')
	}

	scope :order_by_oldest_date_time, -> {
		order(:start_time, :end_time)
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
end
