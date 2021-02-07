@website_viewer = User.return_website_viewer

def get_sunday_of_month(month, year, number_of_sunday_during_month)
	number_of_sunday_during_month = number_of_sunday_during_month*7
	# get the last day of the month, go back until we have a sunday
	Date.new(year, month, number_of_sunday_during_month).downto(0).find(&:sunday?)
end

puts "----------RACE DISTANCES----------"
@five_k = RaceDistance.find_or_create_by(name: "5k", numeric_distance: BigDecimal("3.1"))
puts @five_k.inspect

@ten_k = RaceDistance.find_or_create_by(name: "10k", numeric_distance: BigDecimal("6.2"))
puts @ten_k.inspect

@half_marathon = RaceDistance.find_or_create_by(name: "13.1 Miles", numeric_distance: BigDecimal("13.1"))
puts @half_marathon.inspect

@marathon = RaceDistance.find_or_create_by(name: "26.2 Miles", numeric_distance: BigDecimal("26.2"))
puts @marathon.inspect
puts ""
puts ""

puts "----------5K RACE EXAMPLES----------"
### RACE NAME, CITY, STATE ABBREVIATION, SECONDS, PACE, ELEVATION GAIN ###
five_k_races = [
	["Hot Chocolate 5K", "Chicago", "IL", "US", 1292, "6:57", "167"],
	["Dirty Girl 5k Mud Run", "San Diego", "CA", "US", 1556, "8:22", "129"],
	["Rumpshaker 5K", "New York City", "NY", "US", 2831, "15:13", "506"],
	["Son of a Beach 5K", "Los Angeles", "CA", "US", 2147, "11:33", "304"],
	["Sacks of Love 5K", "Los Angeles", "CA", "US", 1434, "7:43", "409"],
	["Follow the Leader 5k", "Seattle", "WA", "US", 1045, "5:37", "389"],
	["Knight's Challenge 5K", "Los Angeles", "CA", "US", 1151, "6:11", "290"],
	["Lincoln Knights 5K", "Omaha", "NE", "US", 1459, "7:51", "348"],
	["Santa Claus 5k", "Los Angeles", "CA", "US", 2365, "12:43", "274"],
	["Bucktown 5k", "Chicago", "IL", "US", 2694, "14:27", "186"],
	["Saluki 5k", "Carbondale", "IL", "US", 1593, "8:32", "68"],
	["You don't need help 5k", "Austin", "TX", "US", 1485, "7:57", "456"],
	["5K(nights) Foot Race", "Los Angeles", "CA", "US", 1799, "9:39", "654"],
	["Super Hero 5K", "Orlando", "FL", "US", 1879, "10:04", "321"],
	["Turkey Trot 5k", "Los Angeles", "CA", "US", 1988, "10:39", "123"]
]
five_k_races.each do |five_k_race|
	state_id = State.find_by_abbr(five_k_race[2]).id
	country_id = Country.find_by_abbr(five_k_race[3]).id
	@race_example = RaceExample.find_or_create_by(name: five_k_race[0], city: five_k_race[1], state_id: state_id, country_id: country_id, time_in_seconds: five_k_race[4], pace_minutes: five_k_race[5].split(":")[0], pace_seconds: five_k_race[5].split(":")[1], elevation_gain: five_k_race[6], race_distance_id: @five_k.id)
	puts @race_example.inspect
end
puts ""

puts "----------10K RACE EXAMPLES----------"
### RACE NAME, CITY, STATE ABBREVIATION, SECONDS, PACE, ELEVATION GAIN ###
ten_k_races = [
	["Chicago Spring 10k", "Chicago", "IL", "US", 3332, "8:56", "268"],
	["Cold Turkey 10K", "Odenton", "MD", "US", 2911, "7:48", "863"],
	["30A Thanksgiving 10K", "Rosemary", "FL", "US", 2014, "5:24", "473"],
	["Run for the Mandarins 10K Fun Run", "Auburn", "CA", "US", 3229, "8:39", "827"],
	["Broomfield Turkey Day 10K", "Broomfield", "CO", "US", 2385, "6:23", "947"],
	["Burn the Bird 10K", "Great Falls", "MT", "US", 1749, "4:41", "736"],
	["Freeze Your Fanny 10K", "Westerville", "OH", "US", 3128, "8:23", "363"],
	["Lincoln Knights 10K", "Omaha", "NE", "US", 3572, "9:34", "638"],
	["Jamestown S'Klallam Tribe 10K", "Blyn", "WA", "US", 2654, "7:07", "273"],
	["Village Creek 10K Trail Run", "Wayne", "AR", "US", 2712, "7:16", "489"],
	["Java Jog 10K", "Dawsonville", "GA", "US", 3354, "8:59", "726"],
	["Jingle All The 10K", "Houston", "TX", "US", 3023, "8:06", "252"],
	["Gumby 10K", "Granite Bay", "CA", "US", 2378, "6:22", "733"],
	["Chilly Bean 10K", "Lady's Island", "SC", "US", 4305, "11:32", "928"],
	["Sole Mates 10K", "Cary", "NC", "US", 2721, "7:17", "183"]
]
ten_k_races.each do |ten_k_race|
	state_id = State.find_by_abbr(ten_k_races[2]).id
	country_id = Country.find_by_abbr(ten_k_races[3]).id
	@race_example = RaceExample.find_or_create_by(name: ten_k_race[0], city: ten_k_race[1], state_id: state_id, country_id: country_id, time_in_seconds: ten_k_race[4], pace_minutes: ten_k_race[5].split(":")[0], pace_seconds: ten_k_race[5].split(":")[1], elevation_gain: ten_k_race[6], race_distance_id: @ten_k.id)
	puts @race_example.inspect
end
puts ""

puts "----------HALF MARATHON RACE EXAMPLES----------"
### RACE NAME, CITY, STATE ABBREVIATION, HOURS, MINUTES, SECONDS, PACE, ELEVATION GAIN ###
half_marathon_races = [
	["Rock 'n' Roll Half Marathon", "Chicago", "IL", "US", 4279, "5:26", "143"],
	["Naperville Half Marathon", "Naperville", "IL", "US", 9251, "11:46", "205"],
	["Fox Valley Half Marathon", "St. Charles", "IL", "US", 4971, "6:20", "607"],
	["Flying Pirate Half Marathon", "Kitty Hawk", "NC", "US", 6349, "8:04", "9"],
	["Maine Coast Half Marathon", "Biddeford", "ME", "US", 7005, "8:55", "200"],
	["Pacific Crest Half Marathon", "Sunriver", "OR", "US", 10689, "13:35", "106"],
	["All-Out Dog Days Half Marathon", "Westminster", "CO", "US", 6221, "7:54", "302"],
	["San Francisco Marathon Half Marathon", "San Francisco", "CA", "US", 6523, "8:17", "405"],
	["Rock 'n' Roll Virginia Beach Half Marathon", "Virginia Beach", "VA", "US", 5372, "6:50", "210"],
	["Surftown Half Marathon", "Westerly", "RI", "US", 6524, "8:18", "101"],
	["Equinox Half Marathon", "Fort Collins", "CO", "US", 9885, "12:34", "90"],
	["Bay Ridge Half Marathon", "Brooklyn", "NY", "US", 8832, "11:14", "52"],
	["Newport Half Marathon", "Newport", "RI", "US", 8483, "10:47", "21"],
	["Baltimore Running Festival Marathon Half Marathon", "Baltimore", "MD", "US", 5319, "6:46", "501"],
	["Oak Barrel Half Marathon", "Lynchburg", "TN", "US", 5731, "7:17", "404"],
]
half_marathon_races.each do |half_marathon_race|
	state_id = State.find_by_abbr(half_marathon_race[2]).id
	country_id = Country.find_by_abbr(half_marathon_race[3]).id
	@race_example = RaceExample.find_or_create_by(name: half_marathon_race[0], city: half_marathon_race[1], state_id: state_id, country_id: country_id, time_in_seconds: half_marathon_race[4], pace_minutes: half_marathon_race[5].split(":")[0], pace_seconds: half_marathon_race[5].split(":")[1], elevation_gain: half_marathon_race[6], race_distance_id: @half_marathon.id)
	puts @race_example.inspect
end
puts ""

puts "----------MARATHON RACE EXAMPLES----------"
### RACE NAME, CITY, STATE ABBREVIATION, HOURS, MINUTES, SECONDS, PACE, ELEVATION GAIN ###
marathon_races = [
	["California International Marathon", "Sacramento", "CA", "US", 12510, "7:57", "409"],
	["Houston Marathon", "Houston", "TX", "US", 13421, "8:32", "480"],
	["Chicago Marathon", "Chicago", "IL", "US", 15709, "9:59", "689"],
	["New York City Marathon", "New York City", "NY", "US", 10779, "6:51", "1620"],
	["Boston Marathon", "Boston", "MA", "US", 12235, "7:46", "333"],
	["Fox Valley Marathon", "St. Charles", "IL", "US", 15594, "9:55", "452"],
	["Indianapolis Monumental Marathon", "Indianapolis", "IN", "US", 8481, "5:23", "1420"],
	["Twin Cities Marathon", "Minneapolis", "MN", "US", 11373, "7:14", "122"],
	["Grandma's Marathon", "Duluth", "MN", "US", 12621, "8:01", "222"],
	["Marine Corps Marathon", "Arlington", "VA", "US", 17804, "11:19", "302"],
	["Carlsbad Marathon", "Carlsbad", "CA", "US", 10928, "8:33", "1504"],
	["Honolulu Marathon", "Honolulu", "HI", "US", 16461, "10:28", "204"],
	["Los Angeles Marathon", "Los Angeles", "CA", "US", 8135, "5:10", "276"],
	["Walt Disney World Marathon", "Orlando", "FL", "US", 13427, "8:34", "189"],
	["Philadelphia Marathon", "Philadelphia", "PA", "US", 10618, "6:45", "121"]
]
marathon_races.each do |marathon_race|
	state_id = State.find_by_abbr(marathon_race[2]).id
	country_id = Country.find_by_abbr(marathon_race[3]).id
	@race_example = RaceExample.find_or_create_by(name: marathon_race[0], city: marathon_race[1], state_id: state_id, country_id: country_id, time_in_seconds: marathon_race[4], pace_minutes: marathon_race[5].split(":")[0], pace_seconds: marathon_race[5].split(":")[1], elevation_gain: marathon_race[6], race_distance_id: @marathon.id)
	puts @race_example.inspect
end
puts ""


puts "----------WEBSITE VIEWER RACES----------"
@race_distances = RaceDistance.all
###CREATE RACES FOR WEBSITE VIEWER ACCOUNT###
@website_viewer.yearly_totals.exclude_current_year.each do |yearly_total|
	@race_distances.each do |race_distance|
		race_example = race_distance.race_examples.sample

		race_run_type = RunType.named("Race")
		shoe = @website_viewer.shoes.return_random_shoe

		year = yearly_total.year.to_i
		month = rand(1..12)
		day = get_sunday_of_month(month, year, rand(1..4)).day
		start_time = DateTime.new(year, month, day)

		@monthly_total = yearly_total.monthly_totals.of_month(start_time.to_date)

		# Check if there are any runs on the day and delete them if necessary
		@runs_on_date = @website_viewer.runs.return_runs_on_date(month, day, year)
		@runs_on_date.delete_all if @runs_on_date.any?

		if @website_viewer.runs.of_year(yearly_total.year_end).return_races.count <= 6
			new_start_time = Run.return_random_race_start_time(start_time)
			@race = Run.create_with(planned_mileage: race_distance.numeric_distance, mileage_total: race_distance.numeric_distance, 
					time_in_seconds: race_example.time_in_seconds, pace_minutes: race_example.pace_minutes, pace_seconds: race_example.pace_seconds,
			        elevation_gain: race_example.elevation_gain, completed_run: true, shoe_id: shoe.id, city: race_example.city, state_id: race_example.state_id, 
			        country_id: race_example.country_id).find_or_create_by(name: race_example.name, start_time: new_start_time, run_type_id: race_run_type.id, user_id: @website_viewer.id, monthly_total_id: @monthly_total.id)
			puts @race.inspect
			puts ""
		end
	end
end
puts ""

@website_viewer.dynamically_create_website_viewer_races


### WEBSITE VIEWER ACCOUNT - PERSONAL BEST TIMES ###
@website_viewer_runs = @website_viewer.runs
@website_viewer_runs.return_races.update_all(:personal_best => false)
@website_viewer_runs.return_5k_results.order_by_fastest.first.update_column('personal_best', true)
@website_viewer_runs.return_10k_results.order_by_fastest.first.update_column('personal_best', true)
@website_viewer_runs.return_half_marathon_results.order_by_fastest.first.update_column('personal_best', true)
@website_viewer_runs.return_marathon_results.order_by_fastest.first.update_column('personal_best', true)

### UPDATE ALL OF WEBSITE VIEWER TOTALS INCLUDING SHOES ###
@website_viewer.recalculate_all_user_totals_and_shoes