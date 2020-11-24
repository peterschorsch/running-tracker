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
### RACE NAME, CITY, STATE ABBREVIATION, HOURS, MINUTES, SECONDS, PACE, ELEVATION GAIN ###
five_k_races = [
	["Hot Chocolate 5K", "Chicago", "IL", "0", "21", "32", "6:57", "167"],
	["Dirty Girl 5k Mud Run", "San Diego", "CA", "0", "25", "56", "8:22", "129"],
	["Rumpshaker 5K", "New York City", "NY", "0", "47", "11", "15:13", "506"],
	["Son of a Beach 5K", "Los Angeles", "CA", "0", "35", "47", "11:33", "304"],
	["Sacks of Love 5K", "Los Angeles", "CA", "0", "23", "54", "7:43", "409"],
	["Follow the Leader 5k", "Seattle", "WA", "0", "17", "25", "5:37", "389"],
	["Knight's Challenge 5K", "Los Angeles", "CA", "0", "19", "11", "6:11", "290"],
	["Lincoln Knights 5K", "Omaha", "NE", "0", "24", "19", "7:51", "348"],
	["Santa Claus 5k", "Los Angeles", "CA", "0", "39", "25", "12:43", "274"],
	["Bucktown 5k", "Chicago", "IL", "0", "44", "54", "14:27", "186"],
	["Saluki 5k", "Carbondale", "IL", "0", "26", "33", "8:32", "68"],
	["You don't need help 5k", "Austin", "TX", "0", "24", "45", "7:57", "456"],
	["5K(nights) Foot Race", "Los Angeles", "CA", "0", "29", "59", "9:39", "654"],
	["Super Hero 5K", "Orlando", "FL", "0", "31", "19", "10:04", "321"],
	["Turkey Trot 5k", "Los Angeles", "CA", "0", "33", "08", "10:39", "123"]
]
five_k_races.each do |five_k_race|
	@race_example = RaceExample.find_or_create_by(name: five_k_race[0], city: five_k_race[1], state_id: State.find_by_abbr(five_k_race[2]).id, hours: five_k_race[3], minutes: five_k_race[4], seconds: five_k_race[5], pace: five_k_race[6], elevation_gain: five_k_race[7], race_distance_id: @five_k.id)
	puts @race_example.inspect
end
puts ""

puts "----------10K RACE EXAMPLES----------"
### RACE NAME, CITY, STATE ABBREVIATION, HOURS, MINUTES, SECONDS, PACE, ELEVATION GAIN ###
ten_k_races = [
	["Chicago Spring 10k", "Chicago", "IL", "0", "55", "32", "8:56", "268"],
	["Cold Turkey 10K", "Odenton", "MD", "0", "48", "31", "7:48", "863"],
	["30A Thanksgiving 10K", "Rosemary", "FL", "0", "33", "34", "5:24", "473"],
	["Run for the Mandarins 10K Fun Run", "Auburn", "CA", "0", "53", "49", "8:39", "827"],
	["Broomfield Turkey Day 10K", "Broomfield", "CO", "0", "39", "45", "6:23", "947"],
	["Burn the Bird 10K", "Great Falls", "MT", "0", "29", "9", "4:41", "736"],
	["Freeze Your Fanny 10K", "Westerville", "OH", "0", "52", "8", "8:23", "363"],
	["Lincoln Knights 10K", "Omaha", "NE", "0", "59", "32", "9:34", "638"],
	["Jamestown S'Klallam Tribe 10K", "Blyn", "WA", "0", "44", "14", "7:07", "273"],
	["Village Creek 10K Trail Run", "Wayne", "AR", "0", "45", "12", "7:16", "489"],
	["Java Jog 10K", "Dawsonville", "GA", "0", "55", "54", "8:59", "726"],
	["Jingle All The 10K", "Houston", "TX", "0", "50", "23", "8:06", "252"],
	["Gumby 10K", "Granite Bay", "CA", "0", "39", "38", "6:22", "733"],
	["Chilly Bean 10K", "Lady's Island", "SC", "1", "11", "45", "11:32", "928"],
	["Sole Mates 10K", "Cary", "NC", "0", "45", "21", "7:17", "183"]
]
ten_k_races.each do |ten_k_race|
	@race_example = RaceExample.find_or_create_by(name: ten_k_race[0], city: ten_k_race[1], state_id: State.find_by_abbr(ten_k_race[2]).id, hours: ten_k_race[3], minutes: ten_k_race[4], seconds: ten_k_race[5], pace: ten_k_race[6], elevation_gain: ten_k_race[7], race_distance_id: @ten_k.id)
	puts @race_example.inspect
end
puts ""

puts "----------HALF MARATHON RACE EXAMPLES----------"
### RACE NAME, CITY, STATE ABBREVIATION, HOURS, MINUTES, SECONDS, PACE, ELEVATION GAIN ###
half_marathon_races = [
	["Rock 'n' Roll Half Marathon", "Chicago", "IL", "1", "11", "19", "5:26", "143"],
	["Naperville Half Marathon", "Naperville", "IL", "2", "34", "11", "11:46", "205"],
	["Fox Valley Half Marathon", "St. Charles", "IL", "1", "22", "51", "6:20", "607"],
	["Flying Pirate Half Marathon", "Kitty Hawk", "NC", "1", "45", "49", "8:04", "9"],
	["Maine Coast Half Marathon", "Biddeford", "ME", "1", "56", "45", "8:55", "200"],
	["Pacific Crest Half Marathon", "Sunriver", "OR", "2", "58", "9", "13:35", "106"],
	["All-Out Dog Days Half Marathon", "Westminster", "CO", "1", "43", "41", "7:54", "302"],
	["San Francisco Marathon Half Marathon", "San Francisco", "CA", "1", "48", "43", "8:17", "405"],
	["Rock 'n' Roll Virginia Beach Half Marathon", "Virginia Beach", "VA", "1", "29", "32", "6:50", "210"],
	["Surftown Half Marathon", "Westerly", "RI", "1", "48", "44", "8:18", "101"],
	["Equinox Half Marathon", "Fort Collins", "CO", "2", "44", "45", "12:34", "90"],
	["Bay Ridge Half Marathon", "Brooklyn", "NY", "2", "27", "12", "11:14", "52"],
	["Newport Half Marathon", "Newport", "RI", "2", "21", "23", "10:47", "21"],
	["Baltimore Running Festival Marathon Half Marathon", "Baltimore", "MD", "1", "28", "39", "6:46", "501"],
	["Oak Barrel Half Marathon", "Lynchburg", "TN", "1", "35", "31", "7:17", "404"],
]
half_marathon_races.each do |half_marathon_race|
	@race_example = RaceExample.find_or_create_by(name: half_marathon_race[0], city: half_marathon_race[1], state_id: State.find_by_abbr(half_marathon_race[2]).id, hours: half_marathon_race[3], minutes: half_marathon_race[4], seconds: half_marathon_race[5], pace: half_marathon_race[6], elevation_gain: half_marathon_race[7], race_distance_id: @half_marathon.id)
	puts @race_example.inspect
end
puts ""

puts "----------MARATHON RACE EXAMPLES----------"
### RACE NAME, CITY, STATE ABBREVIATION, HOURS, MINUTES, SECONDS, PACE, ELEVATION GAIN ###
marathon_races = [
	["California International Marathon", "Sacramento", "CA", "3", "28", "30", "7:57", "409"],
	["Houston Marathon", "Houston", "TX", "3", "43", "41", "8:32", "480"],
	["Chicago Marathon", "Chicago", "IL", "4", "21", "49", "9:59", "689"],
	["New York City Marathon", "New York City", "NY", "2", "59", "39", "6:51", "1620"],
	["Boston Marathon", "Boston", "MA", "3", "23", "55", "7:46", "333"],
	["Fox Valley Marathon", "St. Charles", "IL", "4", "19", "54", "9:55", "452"],
	["Indianapolis Monumental Marathon", "Indianapolis", "IN", "2", "21", "21", "5:23", "1420"],
	["Twin Cities Marathon", "Minneapolis", "MN", "3", "09", "33", "7:14", "122"],
	["Grandma's Marathon", "Duluth", "MN", "3", "30", "21", "8:01", "222"],
	["Marine Corps Marathon", "Arlington", "VA", "4", "56", "44", "6:57", "302"],
	["Carlsbad Marathon", "Carlsbad", "CA", "3", "44", "24", "8:33", "1504"],
	["Honolulu Marathon", "Honolulu", "HI", "4", "34", "21", "10:28", "204"],
	["Los Angeles Marathon", "Los Angeles", "CA", "2", "15", "35", "5:10", "276"],
	["Walt Disney World Marathon", "Orlando", "FL", "3", "43", "47", "8:34", "189"],
	["Philadelphia Marathon", "Philadelphia", "PA", "2", "56", "58", "6:45", "121"]
]
marathon_races.each do |marathon_race|
	@race_example = RaceExample.find_or_create_by(name: marathon_race[0], city: marathon_race[1], state_id: State.find_by_abbr(marathon_race[2]).id, hours: marathon_race[3], minutes: marathon_race[4], seconds: marathon_race[5], pace: marathon_race[6], elevation_gain: marathon_race[7], race_distance_id: @marathon.id)
	puts @race_example.inspect
end
puts ""

puts "----------WEBSITE VIEWER RACES----------"
###CREATE RACES FOR WEBSITE VIEWER ACCOUNT###
@website_viewer.yearly_totals.each do |yearly_total|
	number_of_races = rand(4..6)
	@race_examples = RaceExample.order("RANDOM()").limit(number_of_races)

	@race_examples.each_with_index do |race_example, index|
		race_distance = race_example.race_distance
		race_run_type = RunType.named("Race")
		gear = Gear.return_default_shoe

		year = yearly_total.year.to_i
		month = rand(1..Date.current.month)
		day = get_sunday_of_month(month, year, rand(1..4)).day
		start_time = DateTime.new(year, month, day)

		@monthly_total = yearly_total.monthly_totals.of_month(start_time)

		if not @website_viewer.runs.return_runs_on_date(month, day, year).any?
			new_start_time = start_time.change(hour: rand(7..8), minute: [0,30].sample, second: 0)
			@race = Run.create(name: race_example.name, start_time: new_start_time, 
		          planned_mileage: race_distance.numeric_distance, mileage_total: race_distance.numeric_distance, hours: race_example.hours, minutes: race_example.minutes, seconds: race_example.seconds, pace: race_example.pace, 
		          elevation_gain: race_example.elevation_gain, city: race_example.city, completed_run: true, active_run: true, 
		          gear_id: gear.id, state_id: @race_example.state_id, run_type_id: race_run_type.id, user_id: @website_viewer.id, monthly_total_id: @monthly_total.id)
			puts @race.inspect
			puts ""
		end
	end
end
puts ""

### WEBSITE VIEWER ACCOUNT - PERSONAL BEST TIMES ###
@website_viewer.runs.return_5k_results.order_by_fastest.first.update_column('personal_best', true)
@website_viewer.runs.return_10k_results.order_by_fastest.first.update_column('personal_best', true)
@website_viewer.runs.return_hm_results.order_by_fastest.first.update_column('personal_best', true)
@website_viewer.runs.return_fm_results.order_by_fastest.first.update_column('personal_best', true)

### WEBSITE VIEWER ACCOUNT - UPDATE MILEAGE OF SHOES ###
@website_viewer.gears.each do |gear|
	gear.update_column('mileage', gear.runs.sum(:mileage_total))
end
