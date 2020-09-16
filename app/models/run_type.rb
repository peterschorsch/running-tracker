class RunType < ApplicationRecord
	has_many :runs

	validates :name, :hex_code, presence: true
	validates :name, :hex_code, :uniqueness => { :scope => :active }, :if => :hex_code_changed?
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
		find_by(default: true, active: true)
	}

	def self.select_run_type_id_name
		self.all.order_by_name.map{ |run_type| [run_type.name, run_type.id] }
	end

	def update_default_shoe(default_param)
		RunType.where.not(:id => self.id).update_all(:default => false) if default_param == 1
	end

	def remove_action_set_new_default
		self.active = false
		self.default = false
		if RunType.default_run_type.exists?
			@first_run_type = RunType.first
			@first_run_type.default = true
			@first_run_type.save
		end
	end

end
