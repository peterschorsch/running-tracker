class State < ApplicationRecord
	scope :find_by_abbr, -> (abbreviation) {
		where(:abbreviation => abbreviation).first
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
