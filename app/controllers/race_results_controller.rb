class RaceResultsController < ApplicationController
	before_action :set_race_run_type

	def index
		@races = current_user.runs.of_run_type(@race_run_type)
		@race_results = @races.includes(:gear).order_by_most_recent.group_by_year

		@personal_bests = current_user.runs.retrieve_personal_bests

		@race_counts = @races.return_race_distance_counts
	end

	private
	def set_race_run_type
		@race_run_type = RunType.named("Race")
	end
end
