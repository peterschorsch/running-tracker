class RunType < ApplicationRecord
	validates :name, :hex_code, presence: true, uniqueness: true
	validates :hex_code, length: { is: 7 }

	scope :active_run_types, -> {
		where(:active => true)
	}

	scope :removed_run_types, -> {
		where(:active => false)
	}

	scope :default_run_type, -> {
		find_by(:default => true)
	}

end
