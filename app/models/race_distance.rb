class RaceDistance < ApplicationRecord
	has_many :races

	validates :name, :distance_miles, presence: true, uniqueness: true

	scope :find_by_distance, -> (miles) {
		find_by(:distance_miles => miles)
	}
end
