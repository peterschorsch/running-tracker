class RaceExample < ApplicationRecord
	belongs_to :state
	belongs_to :race_distance


	scope :named, -> (name) {
	    find_by(name: name)
	}
end
