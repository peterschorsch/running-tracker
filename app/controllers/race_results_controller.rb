class RaceResultsController < ApplicationController
	before_action :set_race_run_type

	def index
		@races = current_user.runs.of_run_type(@race_run_type).includes(gear: :shoe_brand)
		@race_results = @races.includes(:state).order_by_most_recent.group_by_year

		@personal_bests = current_user.runs.retrieve_personal_bests

		@race_counts = @races.return_race_distance_counts

		@testing = current_user.runs.return_races.group(:state_id).count
		@geo_chart = []
		@testing.each do |key, value|
			@geo_chart.push([State.find(key).name, value])
		end
	end

	private
	def set_race_run_type
		@race_run_type = RunType.named("Race")
	end
end
