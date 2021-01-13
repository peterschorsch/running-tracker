class RaceExample < ApplicationRecord
	belongs_to :state
	belongs_to :race_distance

	validates :name, :pace_minutes, :pace_seconds, :time_in_seconds, :elevation_gain, :city, presence: true
	validates :name, uniqueness: true
	validates :elevation_gain, :time_in_seconds, numericality: true
	validates :pace_minutes, :pace_seconds, length: { maximum: 2 }

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

	def pace
		self.pace_minutes + ":" + self.pace_seconds
	end

	def form_convert_elapsed_time(hours=0, minutes=0, seconds=0)
		(hours.to_i*60*60) + (minutes.to_i*60) + seconds.to_i
	end

	def set_necessary_race_example_fields(time_hours, time_minutes, time_seconds)
		### Convert and set hours, minutes, seconds to just seconds ###
		self.set_time_in_seconds(time_hours, time_minutes,time_seconds)
	end

	protected
	def set_time_in_seconds(hours, minutes, seconds)
		self.time_in_seconds = self.form_convert_elapsed_time(hours, minutes, seconds) unless hours.to_i == 0 && minutes.to_i == 0 && seconds.to_i == 0
	end

end
