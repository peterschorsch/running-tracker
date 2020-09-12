class RunType < ApplicationRecord
	has_many :runs

	validates :name, :hex_code, presence: true, uniqueness: true
	validates :hex_code, length: { is: 7 }

	scope :named, -> (run_type) {
		find_by(:name => run_type)
	}

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
