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
	scope :return_states_w_names, -> {
		sort_by_abbr.select(:id, :name)
	}

	scope :return_states_w_abbr, -> {
		sort_by_abbr.select(:id, :abbreviation)
	}
end
