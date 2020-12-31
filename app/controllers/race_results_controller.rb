class RaceResultsController < ApplicationController
	before_action :set_current_user_races, :set_geo_chart_hash

	def index
		@race_results = @races.includes(:state).order_by_most_recent.group_by_year

		@personal_bests = current_user.personal_best_races

		@race_counts = @races.return_race_distance_counts

		@geo_chart_data = @geo_chart_hash.map{ |key, value| [State.find(key).name, value] }
	end

	private
	def set_current_user_races
		@races = current_user.runs.return_races.includes(gear: :shoe_brand)
	end

	def set_geo_chart_hash
		@geo_chart_hash = current_user.runs.return_races.group(:state_id).count
	end
end
