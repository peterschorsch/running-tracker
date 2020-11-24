class RaceExample < ApplicationRecord
	belongs_to :state
	belongs_to :race_distance

	validates :name, :minutes, :seconds, :elevation_gain, :city, presence: true
	validates :elevation_gain, numericality: true
	validates :hours, numericality: true, length: { maximum: 3 }, allow_nil: true
	validates :minutes, numericality: true, length: { in: 0..2 }
	validates :seconds, numericality: true, length: { in: 1..2 }


	scope :named, -> (name) {
	    find_by(name: name)
	}

end
