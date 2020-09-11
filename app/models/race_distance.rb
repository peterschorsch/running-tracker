class RaceDistance < ApplicationRecord
	validates :name, :distance_miles, presence: true, uniqueness: true

	scope :find_by_distance, -> (miles) {
		find_by(:distance_miles => miles)
	}
end
