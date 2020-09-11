class State < ApplicationRecord
	has_many :obligations

	validates :name, :abbreviation, presence: true, uniqueness: true

	scope :find_by_abbr, -> (abbreviation) {
		find_by(:abbreviation => abbreviation)
	}

	scope :sort_by_name, -> {
		order(:name, :abbreviation)
	}

	scope :sort_by_abbr, -> {
		order(:abbreviation, :name)
	}

	### FOR FORMS ###
	def self.select_state_id_name
		self.all.map{ |state| [state.name, state.id] }
	end
end
