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

		raw("<strong>#{Time.at(time_in_seconds).strftime(parse_string)}</strong>")
	end

	# 5h 37m 10s
	def concat_total_time(time_in_seconds)
		minutes, seconds = time_in_seconds.divmod(60)
		hours, minutes = minutes.divmod(60)
		days, hours = hours.divmod(24)

		time = ""
		time += "<strong>#{days}</strong>d " if days != 0
		time += "<strong>#{hours}</strong>h <strong>#{minutes}</strong>m <strong>#{seconds}</strong>s"
		return raw(time)
	end
	# in 30 days & 8 hours
	def concat_countdown_timer(start_time)
		start_time = (start_time - DateTime.current).to_i

		minutes, seconds = start_time.divmod(60)
		hours, minutes = minutes.divmod(60)
		days, hours = hours.divmod(24)

		time = "In "
		time += "<strong>#{days}</strong>" + " day".pluralize(days) + " & " if days != 0
		time += "<strong>#{hours}</strong>" + " hour".pluralize(hours)
		return raw("<small>#{time}</small>")
	end

	# 25 miles/30 miles
	def concat_weekly_total_goal_mileage(record)
		raw("<strong>#{number_precision(record.mileage_total, 3)}</strong> miles/") + raw("<strong>#{number_precision(record.mileage_goal, 3)}</strong> miles")
	end

	# 5 miles | 30:00
	def mileage_and_elasped_time(run)
		concat_distance_miles(run.mileage_total) + " | " + raw("<strong>#{concat_elapsed_time(run.time_in_seconds)}</strong>")
	end
	# 7:30 min/mi | 252 ft
	def pace_and_elevation(run)
		concat_pace_min_miles(run) + " | " + concat_elevation_gain(run.elevation_gain)
	end
	# Adidas Adios 4 (168.6 miles)
	def shoe_with_mileage(shoe)
		raw("<small class='text-muted'>#{return_full_shoe_name(shoe)} (#{return_shoe_mileage(shoe.total_mileage)})</small>")
	end

	# 3 runs | 15 miles | 630 ft
	def concat_run_totals_line_one(record)
		concat_number_of_runs(record.number_of_runs) + " | " + concat_distance_miles(record.mileage_total) + " | " + concat_elevation_gain(record.elevation_gain)
	end
	# 1d 7h 23m 56s
	def concat_run_totals_line_two(record)
		concat_total_time(record.time_in_seconds)
	end
	# 2 runs | 26 miles | 1,252 ft | 2h 58m 23s
	def one_lined_totals(record)
		concat_run_totals_line_one(record) + " | " + concat_run_totals_line_two(record)
	end

	def wt_records_one_lined_total(record)
		concat_number_of_runs(record.number_of_runs) + " | " + concat_elevation_gain(record.elevation_gain) + " | " + concat_total_time(record.time_in_seconds)
	end

	# 1/25-1/31/21
	def concat_date_range_run_total(date_range_helper, record)
		raw(date_range_helper) + " | " + raw(concat_run_totals_line_one(record)) + " | " + raw(concat_run_totals_line_two(record))
	end
	# 3:15PM | Saturday | Jan.23.2021 | Los Angeles, CA
	def concat_small_date_panel(record)
		raw("<small class='text-muted'>#{formatDayofWeek(record.start_time)} | #{format_date_month(record.start_time)} | #{formatTime(record.start_time)} | #{concat_city_state_abbreviation(record)}</small>")
	end

	#def concat_small_date_panel(start_time, city, state)
		#raw("<small class='text-muted'>#{formatDayofWeek(start_time)} | #{format_date_month(start_time)} | #{formatTime(start_time)} | #{concat_city_state_abbreviation(city, state)}</small>")
	#end

	# 7:30 min/mi
	def concat_pace_min_miles(record)
		raw("<strong>#{record.pace_minutes}:#{record.pace_seconds}</strong> min/mi")
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