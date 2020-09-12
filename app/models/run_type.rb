class RunType < ApplicationRecord
	has_many :runs

	validates :name, :hex_code, presence: true, uniqueness: true
	validates :hex_code, length: { is: 7 }

	scope :named, -> (run_type) {
		find_by(:name => run_type)
	}

	scope :order_by_name, ->  {
		order(:name)
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

	def self.select_run_type_id_name
		self.all.order_by_name.map{ |run_type| [run_type.name, run_type.id] }
	end

end
