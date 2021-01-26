class RaceResultsController < ApplicationController
	before_action :set_current_user_races, :set_geo_chart_hash

	def index
		### ALL RACE RESULTS OF CURRENT USER ###
		@race_results = @races.includes(:country).order_by_most_recent.group_by_year

		### PERSONAL BESTS SECTION ###
		### COUNTS OF RACE DISTANCES ###
		@race_distance_counts = @races.return_race_distance_counts
		### COLUMN WIDTH DEPENDING ON NUMBER DIFFERENT OF RACES DISTANCE ###
		race_count = @race_distance_counts.count
		@rd_counts_column_spacing = 12/(race_count == 0 ? 1 : race_count)
		### DATA TO POPULATE MAP OF U.S.A. ###
		@geo_chart_data = @geo_chart_hash.map{ |key, value| [State.find(key).name, value] }
		### PERSONAL BESTS ARRAY ###
		@personal_bests = current_user.personal_best_races
	end

	private
	def set_current_user_races
		@races = current_user.runs.return_races.includes(:state, shoe: :shoe_brand)
	end

	def set_geo_chart_hash
		@geo_chart_hash = @races.where.not(:state_id => nil).group(:state_id).count
	end
end
