class Run < ApplicationRecord
	belongs_to :user
	belongs_to :gear
	belongs_to :state
	belongs_to :run_type

	validates :name, :start_time, :mileage_total, :minutes, :seconds, :elevation_gain, :city, presence: true
	validates :mileage_total, :elevation_gain, numericality: true
	validates :hours, numericality: true, length: { maximum: 3 }, allow_nil: true
	validates :minutes, numericality: true, length: { in: 0..2 }
	validates :seconds, numericality: true, length: { in: 1..2 }


	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :of_run_type, -> (run_type) {
	    where(run_type: run_type)
	}

	scope :retrieve_personal_bests, -> {
		joins(:run_type).where("run_types.name=? AND runs.personal_best=?", "Race", true).order(:mileage_total).includes(:run_type, :state, gear: :shoe_brand)
	}

	scope :order_by_most_recent, -> {
		order('start_time DESC')
	}

	### RETURNS RUNS FROM LAST 7 DAYS IF NO ARGUMENTS ARE PASSED ###
	def self.retrieve_specific_runs(starting_day = DateTime.now.change(hour: 0)-7.days, ending_day = DateTime.now.end_of_day)
		Run.where(start_time: starting_day..ending_day)
	end
	
	def concat_full_location
		self.city + ", " + self.state.name
	end

	def concat_location_abbreviation
		self.city + ", " + self.state.abbreviation
	end
end
