User.exclude_viewer_accounts.each do |user|
  puts "----------#{user.concat_name} ALL TIME TOTALS----------"
  @alltime = AllTimeTotal.create_zero_totals(user.id)
  puts @alltime.inspect
  puts ""

  puts "----------#{user.concat_name} YEARLY TOTALS----------"
  (2017..Date.current.year).each do |year|
    year_date = Date.new(year)
    @yearly_total = YearlyTotal.create_zero_totals(user.id, @alltime.id, year_date)
    puts @yearly_total.inspect

    if year == Date.current.year
      @last_month_of_year = Date.current
      @first_month_of_year = @last_month_of_year.beginning_of_year
    else
      @last_month_of_year = year_date.end_of_year
      @first_month_of_year = @last_month_of_year.beginning_of_year
    end
    puts ""

    puts "----------#{user.concat_name} | #{year} MONTHLY TOTALS----------"
    (@first_month_of_year.month...@last_month_of_year.month+1).each do |month|
      month_end = Date.new(year, month).end_of_month
      month_start = month_end.beginning_of_month
      
      @monthly_total = MonthlyTotal.create_zero_totals(user.id, @yearly_total.id, month_start, month_end)
      puts @monthly_total.inspect
    end
    puts ""
  end

  puts "----------CREATE MOST RECENT FOUR WEEKLY TOTALS FOR ACCOUNT----------"
  WeeklyTotal.create_four_random_weekly_totals(user)

  puts "----------CREATE DEFAULT RUNS FOR CURRENT WEEK----------"
  puts user.create_weeklong_default_runs
  puts ""
end
puts ""

### UPDATE TOTALS FOR MY ACCOUNT ###
@my_account = User.find_user_by_name("Peter", "Schorsch")

puts "----------RACES FOR MY ACCOUNT----------"
run_type_id = RunType.named("Race").id
illinois_state_id = State.find_by_abbr("IL").id
country_id = Country.find_by_name(@my_account.default_country).id

puts "----------2014----------"
@yearly_total = YearlyTotal.create_zero_totals(@my_account.id, @my_account.all_time_total.id, Date.new(2014))
run_date = DateTime.new(2014, 9, 27, 15, 0, 0)
@monthly_total = MonthlyTotal.create_zero_totals(@my_account.id, @yearly_total.id, run_date.beginning_of_month, run_date.end_of_month)
@run = Run.find_or_create_by(name: "4th Annual Saluki Kickoff 5K", planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "1199", pace_minutes: "6", pace_seconds: "24", shoe_id: @my_account.shoes.find_shoe("Wave Rider 15").id, elevation_gain: BigDecimal('0'), city: "Carbondale", state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: @monthly_total.id, completed_run: true)
puts @run.inspect

puts "----------2015----------"
@yearly_total = YearlyTotal.create_zero_totals(@my_account.id, @my_account.all_time_total.id, Date.new(2015))
run_date = DateTime.new(2015, 9, 26, 15, 0, 0)
@monthly_total = MonthlyTotal.create_zero_totals(@my_account.id, @yearly_total.id, run_date.beginning_of_month, run_date.end_of_month)
@run = Run.find_or_create_by(name: "5th Annual Saluki Kickoff 5K", planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "1101", pace_minutes: "5", pace_seconds: "55", shoe_id: @my_account.shoes.find_shoe("Wave Rider 15").id, elevation_gain: BigDecimal('0'), city: "Carbondale", state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: @monthly_total.id, completed_run: true)
puts @run.inspect


puts "----------2017----------"
run_date = DateTime.new(2017, 7, 8, 15, 0, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Chicago Chinatown 5K & Youth Run", planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "1199",  pace_minutes: "6", pace_seconds: "24", shoe_id: @my_account.shoes.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('0'), city: "Chicago", state_id: illinois_state_id, country_id: country_id, notes: "Bib #: 438", run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2017, 7, 15, 13, 30, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "5589",  pace_minutes: "7", pace_seconds: "27", notes: "Bib#: 1386", city: "Chicago", shoe_id: @my_account.shoes.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('64'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2017, 9, 17, 14, 0, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Fox Valley Marathon", planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "11477", pace_minutes: "7", pace_seconds: "18", notes: "Bib#: 727", city: "St. Charles", shoe_id: @my_account.shoes.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('326'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2017, 10, 22, 14, 0, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Naperville Half Marathon and 5K", planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "5148", pace_minutes: "6", pace_seconds: "33", notes: "Bib#: 3800", city: "Naperville", shoe_id: @my_account.shoes.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('0'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

puts "----------2018----------"
run_date = DateTime.new(2018, 5, 20, 14, 50, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Chicago Spring Half Marathon & 10k", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "2301", pace_minutes: "6", pace_seconds: "11", notes: "Bib#: 8111", city: "Chicago", shoe_id: @my_account.shoes.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('6.2'), mileage_total: BigDecimal('6.2'), elevation_gain: BigDecimal('45'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, personal_best: true, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 7, 14, 15, 0, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Chicago Chinatown 5K & Youth Run", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "1104", pace_minutes: "5", pace_seconds: "49", notes: "Bib#: 36", city: "Chicago", shoe_id: @my_account.shoes.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 7, 21, 13, 30, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "4878", pace_minutes: "6", pace_seconds: "12", notes: "Bib#: 1346", city: "Chicago", shoe_id: @my_account.shoes.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('64'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 9, 16, 14, 0, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Fox Valley Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "10308", pace_minutes: "6", pace_seconds: "33", notes: "Bib#:  622", city: "St. Charles", shoe_id: @my_account.shoes.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('326'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 10, 7, 14, 30, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Bank of America Chicago Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "9971", pace_minutes: "6", pace_seconds: "21", notes: "Bib#: 6084", city: "Chicago", shoe_id: @my_account.shoes.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('242'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 10, 21, 14, 0, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Naperville Half Marathon and 5K", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "4797", pace_minutes: "6", pace_seconds: "07", notes: "Bib#: 1473", city: "Naperville", shoe_id: @my_account.shoes.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

puts "----------2019----------"
run_date = DateTime.new(2019, 4, 15, 17, 02, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Boston Marathon", start_time: run_date.in_time_zone("Eastern Time (US & Canada)"), time_in_seconds: "10628", pace_minutes: "6", pace_seconds: "46", notes: "Bib#: 1183", city: "Boston", shoe_id: @my_account.shoes.find_shoe("Ravenna 10").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('655'), state_id: State.find_by_abbr("MA").id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 7, 21, 13, 30, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "4784", pace_minutes: "6", pace_seconds: "05", notes: "Bib#: 1175", city: "Chicago", shoe_id: @my_account.shoes.find_shoe("Kinvara 10").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('64'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, personal_best: true, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 9, 22, 14, 0, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Fox Valley Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "10174", pace_minutes: "6", pace_seconds: "28", notes: "Bib#: 347", city: "St. Charles", shoe_id: @my_account.shoes.find_shoe("Kinvara 10").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('326'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 10, 6, 15, 30, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Bucktown 5K Run", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "1084", pace_minutes: "5", pace_seconds: "49", city: "Chicago", notes: "Bib#: 4291", shoe_id: @my_account.shoes.find_shoe("Adios 4").id, planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, personal_best: true, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 10, 13, 14, 30, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Bank of America Chicago Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), time_in_seconds: "9788", pace_minutes: "6", pace_seconds: "14", notes: "Bib#: 11184", city: "Chicago", shoe_id: @my_account.shoes.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('100'), state_id: illinois_state_id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, personal_best: true, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 11, 3, 17, 42, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "TCS New York City Marathon", start_time: run_date.in_time_zone("Eastern Time (US & Canada)"), time_in_seconds: "11236", pace_minutes: "7", pace_seconds: "09", notes: "Bib#: 2052", city: "New York City", shoe_id: @my_account.shoes.find_shoe_with_color("Cloudswift", "Rock/Slate").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('830'), state_id: State.find_by_abbr("NY").id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

puts "----------2020----------"
run_date = DateTime.new(2020, 3, 8, 13, 55, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: "Skechers Los Angeles Marathon", start_time: run_date, time_in_seconds: "10115", pace_minutes: "6", pace_seconds: "26", notes: "Bib#: 1356", city: "Los Angeles", shoe_id: @my_account.shoes.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('850'), state_id: State.find_by_abbr("CA").id, country_id: country_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

two_days_ago = 2.days.ago
run_date = DateTime.new(two_days_ago.year, two_days_ago.month, two_days_ago.day, 17, 0, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: @my_account.concat_user_default_city_run_name, start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), time_in_seconds: "8903", pace_minutes: "7", pace_seconds: "22", notes: nil, city: "Los Angeles", shoe_id: @my_account.shoes.find_shoe("Adios 4").id, planned_mileage: BigDecimal('20'), mileage_total: BigDecimal('21'), elevation_gain: BigDecimal('1000'), state_id: State.find_by_abbr("CA").id, country_id: country_id, run_type_id: RunType.named("Long Run").id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect

one_day_ago = 1.day.ago
run_date = DateTime.new(one_day_ago.year, one_day_ago.month, one_day_ago.day, 23, 15, 0)
monthly_total_id = MonthlyTotal.of_month(run_date.to_date).id
@run = Run.find_or_create_by(name: @my_account.concat_user_default_city_run_name + " 2", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), time_in_seconds: "1800", pace_minutes: "7", pace_seconds: "30", notes: nil, city: "Los Angeles", shoe_id: @my_account.shoes.find_shoe("Adios 4").id, planned_mileage: BigDecimal('5'), mileage_total: BigDecimal('5'), elevation_gain: BigDecimal('252'), state_id: State.find_by_abbr("CA").id, country_id: country_id, run_type_id: RunType.named("Easy Run").id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true)
puts @run.inspect
puts ""

### REFRESH MY USER TOTALS ###
@my_account.recalculate_all_user_totals_and_shoes


### 2019 YEARLY TOTAL ###
@yearly_total = @my_account.yearly_totals.of_year(Date.new(2019))
@monthly_totals = @yearly_total.monthly_totals

@april = @monthly_totals.of_month(Date.new(2019,4,1)).update_columns(previous_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), previous_number_of_runs: 1, previous_elevation_gain: 655, previous_time_in_seconds: 10628, number_of_runs: 1, elevation_gain: 655, time_in_seconds: 10628)
@july = @monthly_totals.of_month(Date.new(2019,7,1)).update_columns(previous_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), previous_number_of_runs: 1, previous_elevation_gain: 0, previous_time_in_seconds: 4784, number_of_runs: 1, elevation_gain: 655, time_in_seconds: 10628)
@august = @monthly_totals.of_month(Date.new(2019,8,1)).update_columns(previous_mileage: BigDecimal('55.03'), mileage_total: BigDecimal('55.03'), previous_number_of_runs: 8, previous_elevation_gain: 882, previous_time_in_seconds: 23568, number_of_runs: 1, elevation_gain: 655, time_in_seconds: 10628)
@september = @monthly_totals.of_month(Date.new(2019,9,1)).update_columns(previous_mileage: BigDecimal('197.34'), mileage_total: BigDecimal('197.34'), previous_number_of_runs: 25, previous_elevation_gain: 2670, previous_time_in_seconds: 86783, number_of_runs: 1, elevation_gain: 655, time_in_seconds: 10628)
@october = @monthly_totals.of_month(Date.new(2019,10,1)).update_columns(previous_mileage: BigDecimal('131.87'), mileage_total: BigDecimal('131.87'), previous_number_of_runs: 22, previous_elevation_gain: 726, previous_time_in_seconds: 48328, number_of_runs: 1, elevation_gain: 655, time_in_seconds: 10628)
@november = @monthly_totals.of_month(Date.new(2019,11,1)).update_columns(previous_mileage: BigDecimal('70.34'), mileage_total: BigDecimal('70.34'), previous_number_of_runs: 13, previous_elevation_gain: 858, previous_time_in_seconds: 32413, number_of_runs: 1, elevation_gain: 655, time_in_seconds: 10628)
@december = @monthly_totals.of_month(Date.new(2019,12,1)).update_columns(previous_mileage: BigDecimal('150.82'), mileage_total: BigDecimal('150.82'), previous_number_of_runs: 28, previous_elevation_gain: 6709, previous_time_in_seconds: 61901, number_of_runs: 1, elevation_gain: 655, time_in_seconds: 10628)

@yearly_total = @yearly_total.update_columns(mileage_total: @monthly_totals.sum(:mileage_total), number_of_runs: @monthly_totals.sum(:number_of_runs), elevation_gain: @monthly_totals.sum(:elevation_gain), time_in_seconds: 263160)


### 2020 YEARLY TOTAL ###
totals = [
  # MILES, NUMBER OF RUNS, ELEVATION GAIN, TIME IN SECONDS
  [229.05, 29, 12992, 97871], #JAN
  [288.14, 29, 15925, 126278], #FEB
  [151.50, 24, 4265, 63637], #MAR
  [198.1, 27, 4944, 86226], #APR
  [189.23, 27, 5171, 84935], #MAY
  [170.49, 24, 4882, 75940], #JUNE
  [133.31, 21, 3662, 60082], #JULY
  [181.12, 27, 4511, 81610], #AUG
  [166, 26, 4731, 74080], #SEPT
  [163, 27, 4186, 73256], #OCT
  [161.43, 25, 4223, 70873], #NOV
  [175.46, 27, 4636, 77798] #DEC
]

# 2020 yearly total
@yearly_total = @my_account.yearly_totals.of_year(Date.new(2020))
@monthly_totals = @yearly_total.monthly_totals.order_by_oldest_month

@monthly_totals.each_with_index do |monthly_total, index|
  monthly_total.update_columns(previous_mileage: BigDecimal("#{totals[index][0]}"), mileage_total: BigDecimal("#{totals[index][0]}"), previous_number_of_runs: totals[index][1], number_of_runs: totals[index][1], previous_elevation_gain: totals[index][2], elevation_gain: totals[index][2], previous_time_in_seconds: totals[index][3], time_in_seconds: totals[index][3])
end
@yearly_total.update_columns(mileage_total: BigDecimal(@monthly_totals.sum(:mileage_total)), number_of_runs: @monthly_totals.sum(:number_of_runs), elevation_gain: @monthly_totals.sum(:elevation_gain), time_in_seconds: @monthly_totals.sum(:time_in_seconds))

### 2021 YEARLY TOTAL ###
totals = [
  # MILES, NUMBER OF RUNS, ELEVATION GAIN, TIME IN SECONDS
  [173.99, 27, 4636, 77068], #JAN
  [39.09, 6, 1050, 17223] #FEB
]
# 2021 yearly total
@yearly_total = @my_account.yearly_totals.of_year(Date.new(2021))
@monthly_totals = @yearly_total.monthly_totals.order_by_oldest_month

@monthly_totals.each_with_index do |monthly_total, index|
  monthly_total.update_columns(previous_mileage: BigDecimal("#{totals[index][0]}"), mileage_total: BigDecimal("#{totals[index][0]}"), previous_number_of_runs: totals[index][1], number_of_runs: totals[index][1], previous_elevation_gain: totals[index][2], elevation_gain: totals[index][2], previous_time_in_seconds: totals[index][3], time_in_seconds: totals[index][3])
end
@yearly_total.update_columns(mileage_total: BigDecimal(@monthly_totals.sum(:mileage_total)), number_of_runs: @monthly_totals.sum(:number_of_runs), elevation_gain: @monthly_totals.sum(:elevation_gain), time_in_seconds: @monthly_totals.sum(:time_in_seconds))


#Add forzen flag to all yearly totals except current year
@my_account.yearly_totals.where.not(:year => Date.current.year.to_s).each do |yearly_total|
  yearly_total.update_columns(:frozen_flag => true)
  yearly_total.monthly_totals.update_all(:frozen_flag => true)
end

### ALL TIME TOTAL ###
@all_time = @my_account.all_time_total.update_columns(mileage_total: @my_account.yearly_totals.sum(:mileage_total), number_of_runs: @my_account.yearly_totals.sum(:number_of_runs), elevation_gain: @my_account.yearly_totals.sum(:elevation_gain), time_in_seconds: @my_account.yearly_totals.sum(:time_in_seconds))
