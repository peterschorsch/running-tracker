class RaceExample < ApplicationRecord
	belongs_to :state
	belongs_to :race_distance

	validates :name, :time_in_seconds, :elevation_gain, :city, presence: true
	validates :name, uniqueness: true
	validates :elevation_gain, numericality: true
	validates :time_in_seconds, numericality: true

	attr_accessor :hours, :minutes, :seconds


	scope :named, -> (name) {
	    find_by(name: name)
	}

	scope :order_by_fastest, -> {
		order('time_in_seconds ASC')
	}

	scope :group_by_distance, -> {
	    joins(:race_distance).order_by_fastest.group_by { |y| [y.race_distance.id, y.race_distance.name] }
	}

	def set_time_in_seconds(hours, minutes, seconds)
		self.time_in_seconds = self.form_convert_elapsed_time(hours, minutes, seconds) unless hours.to_i == 0 && minutes.to_i == 0 && seconds.to_i == 0
	end

end
