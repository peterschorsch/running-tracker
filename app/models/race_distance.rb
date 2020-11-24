class RaceDistance < ApplicationRecord
	has_many :race_examples

	validates :name, :numeric_distance, presence: true
	validates :numeric_distance, numericality: true

	scope :of_distance, -> (distance) {
	    find_by(numeric_distance: distance)
	}
end
