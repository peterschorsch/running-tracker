class MonthlyTotal < ApplicationRecord

	### MUST SUPPLY PARAMETERS IN DATETIME FORMAT
	scope :find_by_month, -> (starting_month, ending_month) {
		find_by("month_start >= ? and month_end <= ?", starting_month, ending_month)
	}

	### MUST SUPPLY PARAMETERS IN DATETIME FORMAT
	def self.return_monthly_totals(date = DateTime.now)
		self.find_by_month(date.beginning_of_month, date.end_of_month)
	end

	def concat_number_of_runs
		self.number_of_runs.to_s + " runs"
	end

	def concat_total_time
		self.hours.to_s + " hrs " + self.minutes.to_s + " min " + self.seconds.to_s + " sec"
	end

end
