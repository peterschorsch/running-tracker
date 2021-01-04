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
	def concat_elapsed_time(seconds)
        parse_string = seconds < 3600 ? '%M:%S' : '%k:%M:%S'

        Time.at(seconds).utc.strftime(parse_string)
    end

    # 5h 37m 10s
    def concat_total_time(seconds)
	  minutes, seconds = seconds.divmod(60)
	  hours, minutes = minutes.divmod(60)
	  days, hours = hours.divmod(24)

	  raw("<strong>#{hours.to_s.rjust(2)}</strong>h <strong>#{minutes.to_s.rjust(2)}</strong>m <strong>#{seconds}</strong>s")
	end

	# 25 miles/30 miles
	def concat_goal(record)
		raw("<strong>#{number_precision(record.mileage_total, 3)}</strong> miles/") + raw("<strong>#{number_precision(record.goal, 3)}</strong> miles")
	end

	def concat_run_totals_line_one(record)
		concat_number_of_runs(record.number_of_runs) + " | " + concat_distance_miles(record.mileage_total) + " | " + concat_elevation_gain(record.elevation_gain)
	end
	def concat_run_totals_line_two(record)
		concat_total_time(record.seconds)
	end
	def concat_date_range_run_total(date_range_helper, record)
		raw(date_range_helper) + " | " + raw(concat_run_totals_line_one(record)) + " | " + raw(concat_run_totals_line_two(record.seconds))
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
		raw(pluralize("<strong>#{number_precision(number_of_runs, 0)}</strong>", "run"))
	end

	def number_precision(field, precision)
		number_with_precision(field, :number_with_precision => precision, :delimiter => ',', significant: false, strip_insignificant_zeros: true)
	end

end