class RaceExample < ApplicationRecord
	belongs_to :state
	belongs_to :race_distance

	validates :name, :minutes, :seconds, :elevation_gain, :city, presence: true
	validates :name, uniqueness: true
	validates :elevation_gain, numericality: true
	validates :hours, numericality: true, length: { maximum: 3 }, allow_nil: true
	validates :minutes, numericality: true, length: { in: 0..2 }
	validates :seconds, numericality: true, length: { in: 1..2 }


	scope :named, -> (name) {
	    find_by(name: name)
	}

	scope :order_by_fastest, -> {
		order('hours, minutes, seconds')
	}

	scope :group_by_distance, -> {
	    joins(:race_distance).order_by_fastest.group_by { |y| y.race_distance.name }
	}

end
