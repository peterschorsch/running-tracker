module ConcatDistanceTimeFieldsHelper

	# 5 miles
	def concat_distance_miles(mileage)
		raw("<strong>#{number_precision(mileage, 3)}</strong> miles")
	end

	#
	def concat_elapsed_time(hours, minutes, seconds)
		time = ""
		time += (hours.to_s + ":") if hours.to_i != 0 || hours.nil?
		time += minutes.to_s + ":" + seconds.to_s
	end

	# 10 hours 45 min 23 sec
	def concat_total_time(hours, minutes, seconds)
		raw("<strong>#{hours}</strong> hrs | <strong>#{minutes}</strong> min | <strong>#{seconds}</strong> sec")
	end

	def concat_goal(record)
		raw("<strong>#{number_precision(record.mileage_total, 3)}</strong> miles/") + raw("<strong>#{number_precision(record.goal, 3)}</strong> miles")
	end

	def concat_totals(record)
		concat_number_of_runs(record.number_of_runs) + " | " + concat_distance_miles(record.mileage_total) + " | " + concat_elevation_gain(record.elevation_gain) + "<br /><br />".html_safe + concat_total_time(record.hours, record.minutes, record.seconds)
	end

	# 7:30 min/mi
	def concat_pace_min_miles(pace)
		raw("<strong>#{pace}</strong> min/mi")
	end

	# 1,000 ft
	def concat_elevation_gain(elevation_gain)
		raw("<strong>#{number_precision(elevation_gain, 0)}</strong> ft")
	end

	# 100 runs
	def concat_number_of_runs(number_of_runs)
		raw("<strong>#{number_precision(number_of_runs, 0)}</strong> runs")
	end

	def number_precision(field, precision)
		number_with_precision(field, :number_with_precision => precision, :delimiter => ',', significant: true, strip_insignificant_zeros: true)
	end

end