module Race
	extend ActiveSupport::Concern

	### RACE RELATED SCOPES & METHODS ###
	def return_races
		joins(:run_type).where("run_types.name=?", "Race").completed_runs
	end

	def return_future_races
		joins(:run_type).where("run_types.name=?", "Race").where("start_time > ?", DateTime.current).return_uncompleted_runs.order_by_oldest
	end

	# Return runs that aren't races - includes planned runs
	def return_run_workouts
		joins(:run_type).where.not("run_types.name=?", "Race")
	end

	def retrieve_personal_bests
		return_races.where("runs.personal_best=?", true).order(:mileage_total).includes(:state)
	end

	def self.return_race_distance_counts
		totals = self.group(:mileage_total).count
		mappings = { BigDecimal('3.1') => '5K', BigDecimal('6.2') => '10K', BigDecimal('13.1') => 'Half Marathon', BigDecimal('26.2') => 'Marathon' }
		return totals.transform_keys(&mappings.method(:[]))
	end

	def return_5k_results
		where(mileage_total: BigDecimal('3.1')).completed_runs
	end

	def return_10k_results
		where(mileage_total: BigDecimal('6.2')).completed_runs
	end

	def return_half_marathon_results
		where(mileage_total: BigDecimal('13.1')).completed_runs
	end

	def return_marathon_results
		where(mileage_total: BigDecimal('26.2')).completed_runs
	end
end