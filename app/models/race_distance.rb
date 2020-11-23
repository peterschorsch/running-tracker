class RaceDistance < ApplicationRecord
	has_many :race_examples

	scope :of_distance, -> (distance) {
	    find_by(distance: distance)
	}
end
