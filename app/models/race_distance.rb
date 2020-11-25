class RaceDistance < ApplicationRecord
	has_many :race_examples

	validates :name, :numeric_distance, presence: true, uniqueness: true
	validates :numeric_distance, numericality: true

	scope :of_distance, -> (distance) {
	    find_by(numeric_distance: distance)
	}

	def self.select_race_distance_id_name
		self.all.map{ |race_distance| [race_distance.name, race_distance.id] }
	end

end
