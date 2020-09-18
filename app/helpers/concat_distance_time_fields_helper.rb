module ConcatDistanceTimeFieldsHelper

	# Chicago Marathon
	def concat_race_name(name)
		raw("<strong>#{name}</strong>")
	end

	# 5 miles
	def concat_distance_miles(mileage)
		raw("<strong>#{number_precision(mileage, 3)}</strong> miles")
	end

	#
	def concat_elapsed_time(record)
		time = ""
		time += (record.hours.to_s + ":") if record.hours.to_i != 0 || record.hours.nil?
		time += record.minutes.to_s + ":" + record.seconds.to_s
		raw("<strong>#{time}</strong>")
	end

	# 10 hrs | 45 min | 23 sec
	def concat_total_time(record)
		raw("<strong>#{record.hours}</strong> hrs | <strong>#{record.minutes}</strong> min | <strong>#{record.seconds}</strong> sec")
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