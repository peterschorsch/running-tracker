module Modules::UserTotalRecord
	### GET RUNS OF CURRENT WEEK ###
	def runs_of_current_week
		runs.of_week
	end

	### GET CURRENT WEEKLY TOTAL ###
	def current_weekly_total
		weekly_totals.of_week
	end

	### GET CURRENT MONTHLY TOTAL ###
	def current_monthly_total
		monthly_totals.of_month
	end

	### GET CURRENT YEARLY TOTAL ###
	def current_yearly_total
		yearly_totals.of_year
	end

	### RETURN COMPLETED RUNS ON USER RECORD ###
	def return_completed_runs
		runs.completed_runs
	end

	### FREEZE YEARLY, MONTHLY and WEEKLY TOTAL RECORDS THAT AREN'T CURRENT YEAR AND/OR MONTH ###
	def check_on_frozen_total_records
		self.yearly_totals.return_unfrozen_years_except_current_year.freeze_total_records_collection
		self.monthly_totals.return_unfrozen_months_except_current_month.freeze_total_records_collection
		self.weekly_totals.return_unfrozen_weeks_except_past_two_weeks.freeze_total_records_collection
	end

	### CHECK IF USER HAS AN ALL TIME TOTAL RECORD ###
	def check_for_all_time_total_record
		AllTimeTotal.create_with(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, seconds: 0).find_or_create_by(user_id: self.id)
	end

	### CHECK IF USER HAS AN YEARLY TOTAL RECORD ###
	def check_for_current_yearly_total_record
		YearlyTotal.create_with(year_start: Date.current.beginning_of_year, year_end: Date.current.end_of_year, mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0).find_or_create_by(year: Date.current.year, all_time_total_id: self.all_time_total.id, user_id: self.id)
	end

	### CHECK IF USER HAS AN MONTHLY TOTAL RECORD ###
	def check_for_current_monthly_total_record
		MonthlyTotal.create_zero_totals(self.id, self.current_yearly_total.id, Date.current.beginning_of_month, Date.current.end_of_month)
	end

	### UPDATING MILEAGE OF ALL OF A SPECIFIC USER"S SHOES ###
	def recalculate_mileage_of_a_specified_users_shoes
		self.shoes.each do |shoe|
			new_mileage_of_shoe = shoe.runs.completed_runs.sum(:mileage_total)
			shoe.update_columns(:new_mileage => new_mileage_of_shoe, :total_mileage => shoe.previous_mileage + new_mileage_of_shoe)
		end
	end

	### CREATE YEARLY AND MONTHLY TOTAL RECORD IF IT DOESN'T EXIST (depending on start_time) ###
	def create_future_yearly_monthly_total(start_time)
		start_date = start_time.to_date
		@monthly_total = self.monthly_totals.of_month(start_date)

		if @monthly_total.nil?
			@yearly_total = self.yearly_totals.of_year(start_date)
			@yearly_total = YearlyTotal.create_zero_totals(self.id, self.all_time_total.id, start_date) if @yearly_total.nil?

			@monthly_total = MonthlyTotal.create_zero_totals(self.id, @yearly_total.id, start_date.beginning_of_month, start_date.end_of_month)
		end
	end

	### RECALCULATES ALL USER TOTAL RECORDS - DOES INCLUDE SHOE RELATED RECORDS ###
	def recalculate_all_user_totals_and_shoes
		self.recalculate_all_user_totals
		self.recalculate_mileage_of_a_specified_users_shoes
	end

	### RECALCULATES ALL USER TOTAL RECORDS - DOES NOT INCLUDE SHOE RELATED RECORDS ###
	def recalculate_all_user_totals
		self.recalculate_user_all_time_total
		self.recalculate_user_yearly_totals
		self.recalculate_user_monthly_totals
		self.recalculate_user_weekly_totals
	end

	### UPDATING MILEAGE OF ALL OF A SPECIFIC USER"S SHOES ###
	def recalculate_mileage_of_a_specified_users_shoes
		self.shoes.each do |shoe|
			new_mileage_of_shoe = shoe.runs.completed_runs.sum(:mileage_total)
			shoe.update_columns(:new_mileage => new_mileage_of_shoe, :total_mileage => shoe.previous_mileage + new_mileage_of_shoe)
		end
	end

	def recalculate_user_all_time_total
		self.all_time_total.recalculate_all_time_total
	end

	def recalculate_user_yearly_totals
		self.yearly_totals.unfrozen_records.each { |yearly_total| yearly_total.recalculate_yearly_total }
	end

	def recalculate_user_monthly_totals
		self.monthly_totals.unfrozen_records.each { |monthly_total| monthly_total.recalculate_monthly_total }
	end

	def recalculate_user_weekly_totals
		self.weekly_totals.each { |weekly_total| weekly_total.recalculate_weekly_total }
	end

end