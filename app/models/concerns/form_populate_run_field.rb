module FormPopulateRunField
	extend ActiveSupport::Concern

	def run_planned_mileage_select
		(0..30).step(0.1.to_d).map {|i| [i.to_d, i] }
	end

	def run_actual_mileage_select
		(0..30).step(0.01.to_d).map {|i| [i.to_d, i] }
	end

	def run_weekly_mileage_select
		(0..100).step(0.5).map {|i| [i.to_s + " miles", i.to_d] }
	end

	### RANDOMLY GENERATED FIELD NUMBERS ###
	def return_random_run_start_time(date = Date.current)
		DateTime.new(date.year, date.month, date.day, rand(14..19), rand(0..59), 0).localtime
	end

	def return_random_race_start_time(date = Date.current)
		DateTime.new(date.year, date.month, date.day, rand(14..16), [0,30].sample, 0).localtime
	end

	def return_planned_run_start_time(date = Date.current)
		DateTime.new(date.year, date.month, date.day, 16, 0, 0).localtime
	end

	def return_random_mileage
		BigDecimal(rand(1..10))
	end

	def return_random_pace_minutes
		rand(6..10).to_s
	end

	def return_random_pace_seconds
		rand(0..59).to_s.rjust(2, '0')
	end

	def return_random_time_in_seconds
		rand(21600..115200)
	end

	def return_random_elevation_gain
		BigDecimal(rand(50..1000))
	end
end