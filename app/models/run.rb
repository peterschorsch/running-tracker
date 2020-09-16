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

	### CREATE DEFAULT RUNS FOR CURRENT WEEK
	def self.create_weeklong_default_runs(current_user = User.first)
		default_shoe_id = Gear.return_default_shoe.id
		state_id = State.find_by_abbr("CA").id
		run_type_id = RunType.default_run_type.id

		# Current date
		current_date = DateTime.now
		# Starts on a Monday
		week_start_date = current_date.beginning_of_week
		week_end_date = current_date.end_of_week
		loop_week = week_start_date...week_end_date

		loop_week.each_with_index do |date, index|
			@run = Run.find_or_create_by(name: "Default Run #{index+1}", start_time: date,
										hours: 0, minutes: 0, seconds: 0, pace: "0:00", city: "Los Angeles",
										gear_id: default_shoe_id, planned_mileage: BigDecimal('0'),
										elevation_gain: BigDecimal('0'), state_id: state_id, run_type_id: run_type_id,
										user_id: current_user.id, completed_run: false)
		end
	end

	###
	def self.copy_last_weeks_runs(current_user)
		# Last week's date
		last_week_date = DateTime.now-1.week
		# Starts on a Monday
		week_start_date = last_week_date.beginning_of_week
		week_end_date = last_week_date.end_of_week

		default_shoe_id = Gear.return_default_shoe.id
		default_run_type_id = RunType.default_run_type.id

		@last_weeks_runs = Run.of_user(current_user).where(:start_time => week_start_date..week_end_date)
		@last_weeks_runs.each do |run|
			@run = Run.find_or_create_by(name: run.name, start_time: run.start_time+1.week,
										hours: BigDecimal('0'), minutes: BigDecimal('0'), seconds: BigDecimal('0'), pace: "0:00", city: run.city,
										gear_id: default_shoe_id, planned_mileage: run.planned_mileage,
										elevation_gain: BigDecimal('0'), state_id: run.state_id, run_type_id: default_run_type_id,
										user_id: current_user.id, completed_run: false)
		end
	end
end
