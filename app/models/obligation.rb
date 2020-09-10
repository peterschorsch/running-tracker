class Obligation < ApplicationRecord
	belongs_to :state

	validates :name, :start_datetime, :end_datetime, :city, presence: true

	def return_city_state_full
		self.city + ", " + self.state.name
	end

	def return_city_state_abbreviation
		self.city << ", " << self.state.abbreviation
	end
end
