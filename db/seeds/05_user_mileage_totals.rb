User.exclude_viewer_accounts.each do |user|
  puts "----------#{user.concat_name} ALL TIME TOTALS----------"
  @alltime = AllTimeTotal.create_zero_totals(user.id)
  puts @alltime.inspect
  puts ""

  puts "----------#{user.concat_name} YEARLY TOTALS----------"
  (2017..Date.current.year).each do |year|
    year_date = DateTime.new(year)
    @yearly_total = YearlyTotal.create_zero_totals(user.id, @alltime.id, year_date)
    puts @yearly_total.inspect

    if year == Date.current.year
      @last_month_of_year = Date.current
      @first_month_of_year = @last_month_of_year.beginning_of_year
    else
      @last_month_of_year = year_date.end_of_year.end_of_month.in_time_zone("Pacific Time (US & Canada)")
      @first_month_of_year = @last_month_of_year.beginning_of_year
    end
    puts ""

    puts "----------#{user.concat_name} | #{year} MONTHLY TOTALS----------"
    (@first_month_of_year.month...@last_month_of_year.month+1).each do |month|
      month_end = DateTime.new(year, month, Time.days_in_month(month, year), 0, 0, 0, DateTime.now.zone).end_of_day
      month_start = month_end.beginning_of_month
      
      @monthly_total = MonthlyTotal.create_zero_totals(user.id, @yearly_total.id, month_start, month_end)
      puts @monthly_total.inspect
    end
    puts ""
  end

  #puts "----------CREATE MOST RECENT FOUR WEEKLY TOTALS FOR ACCOUNT----------"
  #WeeklyTotal.create_four_random_weekly_totals(user.id)

  puts "----------CREATE DEFAULT RUNS FOR CURRENT WEEK----------"
  puts user.create_weeklong_default_runs
  puts ""
end
puts ""

### UPDATE TOTALS FOR MY ACCOUNT [UPDATED: DECEMBER 2, 2020] ###
@my_account = User.find_user_by_name("Peter", "Schorsch")

puts "----------RACES FOR MY ACCOUNT----------"
  run_type_id = RunType.named("Race").id
  illinois_state_id = State.find_by_abbr("IL").id

  puts "----------2014----------"
  @yearly_total = YearlyTotal.create_zero_totals(@my_account.id, @my_account.all_time_total.id, Date.new(2014))
  run_date = DateTime.new(2014, 9, 27, 8, 0, 0)
  @monthly_total = MonthlyTotal.create_zero_totals(@my_account.id, @yearly_total.id, run_date.beginning_of_month, run_date.end_of_month)
  @run = Run.find_or_create_by(name: "4th Annual Saluki Kickoff 5K", planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "19", seconds: "59", pace: "6:24", gear_id: @my_account.gears.find_shoe("Wave Rider 15").id, elevation_gain: BigDecimal('0'), city: "Carbondale", state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: @monthly_total.id, completed_run: true, active_run: true)
  puts @run.inspect

  puts "----------2015----------"
  @yearly_total = YearlyTotal.create_zero_totals(@my_account.id, @my_account.all_time_total.id, Date.new(2015))
  run_date = DateTime.new(2015, 9, 26, 8, 0, 0)
  @monthly_total = MonthlyTotal.create_zero_totals(@my_account.id, @yearly_total.id, run_date.beginning_of_month, run_date.end_of_month)
  @run = Run.find_or_create_by(name: "5th Annual Saluki Kickoff 5K", planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "18", seconds: "21", pace: "5:55", gear_id: @my_account.gears.find_shoe("Wave Rider 15").id, elevation_gain: BigDecimal('0'), city: "Carbondale", state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: @monthly_total.id, completed_run: true, active_run: true)
  puts @run.inspect


  puts "----------2017----------"
  run_date = DateTime.new(2017, 7, 8, 8, 0, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Chicago Chinatown 5K & Youth Run", planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "19", seconds: "59", pace: "6:26", gear_id: @my_account.gears.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('0'), city: "Chicago", state_id: illinois_state_id, notes: "Bib #: 438", run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2017, 7, 15, 6, 30, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "33", seconds: "09", pace: "7:27", notes: "Bib#: 1386", city: "Chicago", gear_id: @my_account.gears.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('64'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2017, 9, 17, 7, 0, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Fox Valley Marathon", planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "3", minutes: "11", seconds: "17", pace: "7:18", notes: "Bib#: 727", city: "St. Charles", gear_id: @my_account.gears.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('326'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2017, 10, 22, 7, 0, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Naperville Half Marathon and 5K", planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "25", seconds: "48", pace: "6:33", notes: "Bib#: 3800", city: "Naperville", gear_id: @my_account.gears.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  puts "----------2018----------"
  run_date = DateTime.new(2018, 5, 20, 7, 50, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Chicago Spring Half Marathon & 10k", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "38", seconds: "21", pace: "6:11", notes: "Bib#: 8111", city: "Chicago", gear_id: @my_account.gears.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('6.2'), mileage_total: BigDecimal('6.2'), elevation_gain: BigDecimal('45'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, personal_best: true, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 7, 14, 8, 0, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Chicago Chinatown 5K & Youth Run", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "18", seconds: "04", pace: "5:49", notes: "Bib#: 36", city: "Chicago", gear_id: @my_account.gears.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 7, 21, 6, 30, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "21", seconds: "18", pace: "6:12", notes: "Bib#: 1346", city: "Chicago", gear_id: @my_account.gears.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('64'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 9, 16, 7, 0, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Fox Valley Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "51", seconds: "48", pace: "6:33", notes: "Bib#:  622", city: "St. Charles", gear_id: @my_account.gears.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('326'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 10, 7, 7, 30, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Bank of America Chicago Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "46", seconds: "11", pace: "6:21", notes: "Bib#: 6084", city: "Chicago", gear_id: @my_account.gears.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('242'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 10, 21, 7, 0, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Naperville Half Marathon and 5K", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "19", seconds: "57", pace: "6:07", notes: "Bib#: 1473", city: "Naperville", gear_id: @my_account.gears.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  puts "----------2019----------"
  run_date = DateTime.new(2019, 4, 15, 10, 02, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Boston Marathon", start_time: run_date.in_time_zone("Eastern Time (US & Canada)"), hours: "2", minutes: "57", seconds: "08", pace: "6:46", notes: "Bib#: 1183", city: "Boston", gear_id: @my_account.gears.find_shoe("Ravenna 10").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('655'), state_id: State.find_by_abbr("MA").id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 7, 21, 6, 30, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "19", seconds: "44", pace: "6:05", notes: "Bib#: 1175", city: "Chicago", gear_id: @my_account.gears.find_shoe("Kinvara 10").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('64'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, personal_best: true, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 9, 22, 7, 0, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Fox Valley Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "49", seconds: "34", pace: "6:28", notes: "Bib#: 347", city: "St. Charles", gear_id: @my_account.gears.find_shoe("Kinvara 10").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('326'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 10, 6, 8, 30, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Bucktown 5K Run", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "18", seconds: "4", pace: "5:49", city: "Chicago", notes: "Bib#: 4291", gear_id: @my_account.gears.find_shoe("Adios 4").id, planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, personal_best: true, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 10, 13, 7, 30, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Bank of America Chicago Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "43", seconds: "08", pace: "6:14", notes: "Bib#: 11184", city: "Chicago", gear_id: @my_account.gears.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('100'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, personal_best: true, completed_run: true, active_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 11, 3, 9, 42, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "TCS New York City Marathon", start_time: run_date.in_time_zone("Eastern Time (US & Canada)"), hours: "3", minutes: "7", seconds: "16", pace: "7:09", notes: "Bib#: 2052", city: "New York City", gear_id: @my_account.gears.find_shoe_with_color("Cloudswift", "Rock/Slate").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('830'), state_id: State.find_by_abbr("NY").id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  puts "----------2020----------"
  run_date = DateTime.new(2020, 3, 8, 6, 55, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Skechers Los Angeles Marathon", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), hours: "2", minutes: "48", seconds: "35", pace: "6:26", notes: "Bib#: 1356", city: "Los Angeles", gear_id: @my_account.gears.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('850'), state_id: State.find_by_abbr("CA").id, run_type_id: run_type_id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  two_days_ago = 2.days.ago
  run_date = DateTime.new(two_days_ago.year, two_days_ago.month, two_days_ago.day, 10, 0, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Testing", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), hours: "2", minutes: "28", seconds: "23", pace: "7:02", notes: nil, city: "Los Angeles", gear_id: @my_account.gears.find_shoe("Adios 4").id, planned_mileage: BigDecimal('20'), mileage_total: BigDecimal('21'), elevation_gain: BigDecimal('1000'), state_id: State.find_by_abbr("CA").id, run_type_id: RunType.named("Long Run").id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect

  one_day_ago = 1.day.ago
  run_date = DateTime.new(one_day_ago.year, one_day_ago.month, one_day_ago.day, 18, 15, 0)
  monthly_total_id = MonthlyTotal.of_month(run_date).id
  @run = Run.find_or_create_by(name: "Testing 2", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), hours: 0, minutes: "30", seconds: "00", pace: "7:30", notes: nil, city: "Los Angeles", gear_id: @my_account.gears.find_shoe("Adios 4").id, planned_mileage: BigDecimal('5'), mileage_total: BigDecimal('5'), elevation_gain: BigDecimal('252'), state_id: State.find_by_abbr("CA").id, run_type_id: RunType.named("Easy Run").id, user_id: @my_account.id, monthly_total_id: monthly_total_id, completed_run: true, active_run: true)
  puts @run.inspect
  puts ""

### 2014 YEARLY TOTAL ###
@yearly_total = @my_account.yearly_totals.of_year(Date.new(2014).year)
@yearly_total.update_columns(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0)
@yearly_total.monthly_totals.update_all(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0)
@my_account.runs.of_year(Date.new(@yearly_total.year.to_i)).each do |run|
  run.update_user_run_totals(run.monthly_total)
  run.update_user_run_totals(run.monthly_total.yearly_total)
end

### 2015 YEARLY TOTAL ###
@yearly_total = @my_account.yearly_totals.of_year(Date.new(2015).year)
@yearly_total.update_columns(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0)
@yearly_total.monthly_totals.update_all(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0)
@my_account.runs.of_year(Date.new(@yearly_total.year.to_i)).each do |run|
  run.update_user_run_totals(run.monthly_total)
  run.update_user_run_totals(run.monthly_total.yearly_total)
end

### 2017 YEARLY TOTAL ###
@yearly_total = @my_account.yearly_totals.of_year(Date.new(2017).year)
@yearly_total.update_columns(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0)
@yearly_total.monthly_totals.update_all(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0)
@my_account.runs.of_year(Date.new(@yearly_total.year.to_i)).each do |run|
  run.update_user_run_totals(run.monthly_total)
  run.update_user_run_totals(run.monthly_total.yearly_total)
end

### 2018 YEARLY TOTAL ###
@yearly_total = @my_account.yearly_totals.of_year(Date.new(2018).year)
@yearly_total.update_columns(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0)
@yearly_total.monthly_totals.update_all(mileage_total: BigDecimal('0'), number_of_runs: 0, elevation_gain: 0, hours: 0, minutes: 0, seconds: 0)
@my_account.runs.of_year(Date.new(@yearly_total.year.to_i)).each do |run|
  run.update_user_run_totals(run.monthly_total)
  run.update_user_run_totals(run.monthly_total.yearly_total)
end


### 2019 YEARLY TOTAL ###
@yearly_total = @my_account.yearly_totals.of_year(Date.new(2019).year)
@monthly_totals = @yearly_total.monthly_totals

@april = @monthly_totals.of_month(Date.new(2019,4,1)).update_columns(mileage_total: BigDecimal('26.2'), number_of_runs: 1, elevation_gain: 655, hours: 2, minutes: 57, seconds: 8)
@july = @monthly_totals.of_month(Date.new(2019,7,1)).update_columns(mileage_total: BigDecimal('13.1'), number_of_runs: 1, elevation_gain: 0, hours: 1, minutes: 19, seconds: 44)
@august = @monthly_totals.of_month(Date.new(2019,8,1)).update_columns(mileage_total: BigDecimal('55.03'), number_of_runs: 8, elevation_gain: 882, hours: 6, minutes: 32, seconds: 48)
@september = @monthly_totals.of_month(Date.new(2019,9,1)).update_columns(mileage_total: BigDecimal('197.34'), number_of_runs: 25, elevation_gain: 2670, hours: 24, minutes: 06, seconds: 23)
@october = @monthly_totals.of_month(Date.new(2019,10,1)).update_columns(mileage_total: BigDecimal('131.87'), number_of_runs: 22, elevation_gain: 726, hours: 13, minutes: 25, seconds: 28)
@november = @monthly_totals.of_month(Date.new(2019,11,1)).update_columns(mileage_total: BigDecimal('70.34'), number_of_runs: 13, elevation_gain: 858, hours: 8, minutes: 30, seconds: 13)
@december = @monthly_totals.of_month(Date.new(2019,12,1)).update_columns(mileage_total: BigDecimal('150.82'), number_of_runs: 28, elevation_gain: 6709, hours: 17, minutes: 11, seconds: 41)

@yearly_total = @yearly_total.update_columns(mileage_total: @monthly_totals.sum(:mileage_total), number_of_runs: @monthly_totals.sum(:number_of_runs), elevation_gain: @monthly_totals.sum(:elevation_gain), hours: 73, minutes: 6, seconds: 0)


### 2020 YEARLY TOTAL [UPDATED: NOVEMBER 27, 2020] ###
totals = [
  # MILES, NUMBER OF RUNS, ELEVATION GAIN, HOURS, MINUTES, SECONDS
  [229.05, 29, 12992, 27, 11, 11], #JAN
  [288.14, 29, 15925, 35, 04, 38], #FEB
  [151.50, 24, 4265, 17, 40, 37], #MAR
  [198.1, 27, 4944, 23, 57, 06], #APR
  [189.23, 27, 5171, 23, 35, 35], #MAY
  [170.49, 24, 4882, 21, 05, 40], #JUNE
  [133.31, 21, 3662, 16, 41, 22], #JULY
  [181.12, 27, 4511, 22, 40, 10], #AUG
  [166, 26, 4731, 20, 34, 40], #SEPT
  [163, 27, 4186, 20, 20, 56], #OCT
  [178.8, 21, 3589, 16, 45, 21], #NOV
  [149.49, 23, 3950, 18, 25, 48] #DEC AS OF DEC 26
]
@yearly_total = @my_account.yearly_totals.of_year(Date.new(2020).year)
@monthly_totals = @yearly_total.monthly_totals.order_by_oldest_month

@monthly_totals.each_with_index do |monthly_total, index|
  monthly_total.update_columns(mileage_total: BigDecimal("#{totals[index][0]}"), number_of_runs: totals[index][1], elevation_gain: totals[index][2], hours: totals[index][3], minutes: totals[index][4], seconds: totals[index][5])
end
@yearly_total.update_columns(mileage_total: BigDecimal(@monthly_totals.sum(:mileage_total)), number_of_runs: @monthly_totals.sum(:number_of_runs), elevation_gain: @monthly_totals.sum(:elevation_gain), hours: 245, minutes: 37, seconds: 26)

### ALL TIME TOTAL ###
@all_time = @my_account.all_time_total.update_columns(mileage_total: @my_account.yearly_totals.sum(:mileage_total), number_of_runs: @my_account.yearly_totals.sum(:number_of_runs), elevation_gain: @my_account.yearly_totals.sum(:elevation_gain), hours: 319, minutes: 40, seconds: 52)
