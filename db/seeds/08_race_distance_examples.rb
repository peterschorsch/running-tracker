@website_viewer = User.return_website_viewer

puts "----------RACE DISTANCES----------"
@five_k = RaceDistance.find_or_create_by(distance: "5k") 
puts @five_k.inspect

@ten_k = RaceDistance.find_or_create_by(distance: "10k")
puts @ten_k.inspect

@half_marathon = RaceDistance.find_or_create_by(distance: "13.1 Miles")
puts @half_marathon.inspect

@marathon = RaceDistance.find_or_create_by(distance: "26.2 Miles")
puts @marathon.inspect
puts ""
puts ""

puts "----------5K RACE EXAMPLES----------"
five_k_races = [
	["Hot Chocolate 5K", "Chicago", "IL"],
	["Dirty Girl 5k Mud Run", "San Diego", "CA"],
	["Rumpshaker 5K", "New York City", "NY"],
	["Son of a Beach 5K", "Los Angeles", "CA"],
	["Sacks of Love 5K", "Los Angeles", "CA"],
	["Follow the Leader 5k", "Seattle", "WA"],
	["Knight's Challenge 5K", "Los Angeles", "CA"],
	["Lincoln Knights 5K", "Omaha", "NE"],
	["Santa Claus 5k", "Los Angeles", "CA"],
	["Bucktown 5k", "Chicago", "IL"],
	["Saluki 5k", "Carbondale", "IL"],
	["You don't need help 5k", "Austin", "TX"],
	["5K(nights) Foot Race", "Los Angeles", "CA"],
	["Super Hero 5K", "Orlando", "FL"],
	["Turkey Trot 5k", "Los Angeles", "CA"]
]
five_k_races.each do |five_k_race|
	@race_example = RaceExample.find_or_create_by(name: five_k_race[0], city: five_k_race[1], state_id: State.find_by_abbr(five_k_race[2]).id, race_distance_id: @five_k.id)
	puts @race_example.inspect
end
puts ""

puts "----------10K RACE EXAMPLES----------"
ten_k_races = [
	["Chicago Spring 10k", "Chicago", "IL"],
	["Cold Turkey 10K", "Odenton", "MD"],
	["30A Thanksgiving 10K", "Rosemary", "FL"],
	["Run for the Mandarins 10K Fun Run", "Auburn", "CA"],
	["Broomfield Turkey Day 10K", "Broomfield", "CO"],
	["Burn the Bird 10K", "Great Falls", "MT"],
	["Freeze Your Fanny 10K", "Westerville", "OH"],
	["Lincoln Knights 5K", "Omaha", "NE"],
	["Jamestown S'Klallam Tribe 10K", "Blyn", "WA"],
	["Village Creek 10K Trail Run", "Wayne", "AR"],
	["Java Jog 10K", "Dawsonville", "GA"],
	["Jingle All The 10K", "Houston", "TX"],
	["Gumby 10K", "Granite Bay", "CA"],
	["Chilly Bean 10K", "Lady's Island", "SC"],
	["Sole Mates 10K", "Cary", "NC"]
]
ten_k_races.each do |ten_k_race|
	@race_example = RaceExample.find_or_create_by(name: ten_k_race[0], city: ten_k_race[1], state_id: State.find_by_abbr(ten_k_race[2]).id, race_distance_id: @ten_k.id)
	puts @race_example.inspect
end
puts ""

puts "----------HALF MARATHON RACE EXAMPLES----------"
half_marathon_races = [
	["Rock 'n' Roll Half Marathon", "Chicago", "IL"],
	["Naperville Half Marathon", "Naperville", "IL"],
	["Fox Valley Half Marathon", "St. Charles", "IL"],
	["Flying Pirate Half Marathon", "Kitty Hawk", "NC"],
	["Maine Coast Half Marathon", "Biddeford", "ME"],
	["Pacific Crest Half Marathon", "Sunriver", "OR"],
	["All-Out Dog Days Half Marathon", "Westminster", "CO"],
	["San Francisco Marathon Half Marathon", "San Francisco", "CA"],
	["Rock 'n' Roll Virginia Beach Half Marathon", "Virginia Beach", "VA"],
	["Surftown Half Marathon", "Westerly", "RI"],
	["Equinox Half Marathon", "Fort Collins", "CO"],
	["Bay Ridge Half Marathon", "Brooklyn", "NY"],
	["Newport Half Marathon", "Newport", "RI"],
	["Baltimore Running Festival Marathon Half Marathon", "Baltimore", "MD"],
	["Oak Barrel Half Marathon", "Lynchburg", "TN"],
]
half_marathon_races.each do |half_marathon_race|
	@race_example = RaceExample.find_or_create_by(name: half_marathon_race[0], city: half_marathon_race[1], state_id: State.find_by_abbr(half_marathon_race[2]).id, race_distance_id: @half_marathon.id)
	puts @race_example.inspect
end
puts ""

puts "----------MARATHON RACE EXAMPLES----------"
marathon_races = [
	["California International Marathon", "Sacramento", "CA"],
	["Houston Marathon", "Houston", "TX"],
	["Chicago Marathon", "Chicago", "IL"],
	["New York City Marathon", "New York City", "NY"],
	["Boston Marathon", "Boston", "MA"],
	["Fox Valley Marathon", "St. Charles", "IL"],
	["Indianapolis Monumental Marathon", "Indianapolis", "IN"],
	["Twin Cities Marathon", "Minneapolis", "MN"],
	["Grandma's Marathon", "Duluth", "MN"],
	["Marine Corps Marathon", "Arlington", "VA"],
	["Carlsbad Marathon", "Carlsbad", "CA"],
	["Honolulu Marathon", "Honolulu", "HI"],
	["Los Angeles Marathon", "Los Angeles", "CA"],
	["Walt Disney World Marathon", "Orlando", "FL"],
	["Philadelphia Marathon", "Philadelphia", "PA"]
]
marathon_races.each do |marathon_race|
	@race_example = RaceExample.find_or_create_by(name: marathon_race[0], city: marathon_race[1], state_id: State.find_by_abbr(marathon_race[2]).id, race_distance_id: @marathon.id)
	puts @race_example.inspect
end
puts ""

###CREATE RACES FOR YEAR###
#@website_viewer.yearly_totals.each do |yearly_total|
#	end_point = rand(2..6)
#	(0..end_point).each do |number|    
#		Run.create(name: "LA Running", start_time: run_date.change(hour: rand(6..19), minute: rand(0..60), second: rand(0..60)), 
#	          planned_mileage: BigDecimal(rand(10)), mileage_total: BigDecimal(rand(10)), hours: rand(0..2), minutes: rand(1..60), seconds: rand(1..60), pace: pace, 
#	          elevation_gain: BigDecimal(rand(50..1000)), city: "Los Angeles", completed_run: true, active_run: true, 
#	          gear_id: gear_id, state_id: california_state_id, run_type_id: run_type_id, user_id: @website_viewer.id, monthly_total_id: @monthly_total.id)
#	end
#end