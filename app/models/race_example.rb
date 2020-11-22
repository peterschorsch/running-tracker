class RaceExample < ApplicationRecord
	belongs_to :state
	has_many :race_distances
end
