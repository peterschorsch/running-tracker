module ConcatDistanceTimeFieldsHelper

	# Chicago Marathon
	def concat_race_name(name)
		raw("<strong>#{name}</strong>")
	end

	# 5 miles
	def concat_distance_miles(mileage)
		raw("<strong>#{number_precision(mileage, 3)}</strong>") + " mile".pluralize(mileage)
	end

	# 5:37:10
	def concat_elapsed_time(time_in_seconds)
		parse_string = time_in_seconds < 3600 ? '%M:%S' : '%k:%M:%S'

		raw("<strong>#{Time.at(time_in_seconds).utc.strftime(parse_string)}</strong>")
	end

	# 5h 37m 10s
	def concat_total_time(time_in_seconds)
		minutes, time_in_seconds = time_in_seconds.divmod(60)
		hours, minutes = minutes.divmod(60)
		days, hours = hours.divmod(24)

		raw("<strong>#{hours.to_s.rjust(2)}</strong>h <strong>#{minutes.to_s.rjust(2)}</strong>m <strong>#{time_in_seconds}</strong>s")
	end

	# 25 miles/30 miles
	def concat_goal(record)
		raw("<strong>#{number_precision(record.mileage_total, 3)}</strong> miles/") + raw("<strong>#{number_precision(record.goal, 3)}</strong> miles")
	end

	def concat_run_totals_line_one(record)
		concat_number_of_runs(record.number_of_runs) + " | " + concat_distance_miles(record.mileage_total) + " | " + concat_elevation_gain(record.elevation_gain)
	end
	def concat_run_totals_line_two(time_in_seconds)
		concat_total_time(time_in_seconds)
	end
	def concat_date_range_run_total(date_range_helper, record)
		raw(date_range_helper) + " | " + raw(concat_run_totals_line_one(record)) + " | " + raw(concat_run_totals_line_two(record.time_in_seconds))
	end
	def concat_small_date_panel(start_time, city, state)
		raw("<small class='text-muted'>#{formatTime(start_time)} | #{formatDayofWeek(start_time)} | #{format_date_month(start_time)} | #{concat_city_state_abbreviation(city, state)}</small>")
	end

	# 7:30 min/mi
	def concat_pace_min_miles(pace)
		raw("<strong>#{pace}</strong> min/mi")
	end

	# 1,000 ft
	def concat_elevation_gain(elevation_gain)
		raw("<strong>#{number_precision(elevation_gain, 70)}</strong> ft")
	end

	# 100 runs
	def concat_number_of_runs(number_of_runs)
		raw("<strong>#{number_precision(number_of_runs, 3)}</strong>") + " run".pluralize(number_of_runs)
	end

	def number_precision(field, precision)
		number_with_precision(field, :number_with_precision => precision, :delimiter => ',', significant: false, strip_insignificant_zeros: true)
	end

end