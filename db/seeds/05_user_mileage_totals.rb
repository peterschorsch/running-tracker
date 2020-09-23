User.exclude_viewer_accounts.each do |user|
  puts "----------#{user.concat_name} ALL TIME TOTALS----------"
  @alltime = AllTimeTotal.create_with(mileage_total: BigDecimal(rand(3500..10000)), elevation_gain: rand(60000..150000), number_of_runs: rand(500..1000), hours: rand(250..500), minutes: rand(1..59), seconds: rand(1..59)).find_or_create_by(user_id: user.id)
  puts @alltime.inspect
  puts ""

  puts "----------#{user.concat_name} YEARLY TOTALS----------"
  (2017..Date.current.year).each do |year|
    year_date = DateTime.new(year)
    @yearly_total = YearlyTotal.create_with(mileage_total: BigDecimal(rand(1000..2500)), elevation_gain: rand(22000..60000), number_of_runs: rand(220..310), hours: rand(100..200), minutes: rand(1..59), seconds: rand(1..59)).find_or_create_by(year: year, year_start: year_date.beginning_of_year.in_time_zone("Pacific Time (US & Canada)"), year_end: year_date.end_of_year.in_time_zone("Pacific Time (US & Canada)"), user_id: user.id, all_time_total_id: @alltime.id)
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
      
      @monthly_total = MonthlyTotal.create_with(mileage_total: BigDecimal(rand(100..250)), elevation_gain: rand(2500..10000), number_of_runs: rand(20..30), hours: rand(12..50), minutes: rand(1..59), seconds: rand(1..59)).find_or_create_by(user_id: user.id, yearly_total_id: @yearly_total.id, month_start: month_start, month_end: month_end)
      puts @monthly_total.inspect
    end
    puts ""
  end

  puts "----------CREATE MOST RECENT FOUR WEEKLY TOTALS FOR MY ACCOUNT----------"
  current_date = DateTime.now
  mileage_total = rand(15..75)
  mileage_goal = 40
  met_goal = mileage_total >= mileage_goal ? true : false
  @weekly_total = WeeklyTotal.create_with(mileage_total: BigDecimal(mileage_total), mileage_goal: BigDecimal(mileage_goal), met_goal: met_goal, hours: rand(5..20), minutes: rand(1..59), seconds: rand(1..59), number_of_runs: rand(1..7), elevation_gain: rand(500..5000)).find_or_create_by(week_start: current_date.beginning_of_week, week_end: current_date.end_of_week, user_id: user.id)
  puts @weekly_total.inspect
  (1..3).each do |number|
    @weekly_total = WeeklyTotal.create_with(mileage_total: rand(5..39), mileage_goal: mileage_goal, met_goal: false, hours: rand(5..20), minutes: rand(1..59), seconds: rand(1..59), number_of_runs: rand(1..7), elevation_gain: rand(500..5000)).find_or_create_by(week_start: current_date.beginning_of_week-number.week, week_end: current_date.end_of_week-number.week, user_id: user.id)
    puts @weekly_total.inspect
  end
  puts ""

  puts "----------CREATE DEFAULT RUNS FOR CURRENT WEEK----------"
  puts Run.create_weeklong_default_runs(user)
  puts ""


  puts "----------RUNS----------"
  run_type_id = RunType.named("Race").id
  illinois_state_id = State.find_by_abbr("IL").id

  puts "----------2017----------"
  run_date = DateTime.new(2017, 7, 8, 8, 0, 0)
  @run = Run.find_or_create_by(name: "Chicago Chinatown 5K & Youth Run", planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "19", seconds: "59", pace: "6:26", gear_id: Gear.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('0'), city: "Chicago", state_id: illinois_state_id, notes: "Bib #: 438", run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2017, 7, 15, 6, 30, 0)
  @run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "33", seconds: "09", pace: "7:27", notes: "Bib#: 1386", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('150'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2017, 9, 17, 7, 0, 0)
  @run = Run.find_or_create_by(name: "Fox Valley Marathon", planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "3", minutes: "11", seconds: "17", pace: "7:18", notes: "Bib#: 727", city: "St. Charles", gear_id: Gear.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('326'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2017, 10, 22, 7, 0, 0)
  @run = Run.find_or_create_by(name: "Naperville Half Marathon and 5K", planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "25", seconds: "48", pace: "6:33", notes: "Bib#: 3800", city: "Naperville", gear_id: Gear.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  puts "----------2018----------"
  run_date = DateTime.new(2018, 5, 20, 7, 50, 0)
  @run = Run.find_or_create_by(name: "Chicago Spring Half Marathon & 10k", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "38", seconds: "21", pace: "6:11", notes: "Bib#: 8111", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('6.2'), mileage_total: BigDecimal('6.2'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, personal_best: true, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 7, 14, 8, 0, 0)
  @run = Run.find_or_create_by(name: "Chicago Chinatown 5K & Youth Run", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "18", seconds: "04", pace: "5:49", notes: "Bib#: 36", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 7, 21, 6, 30, 0)
  @run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "21", seconds: "18", pace: "6:12", notes: "Bib#: 1346", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 9, 16, 7, 0, 0)
  @run = Run.find_or_create_by(name: "Fox Valley Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "51", seconds: "48", pace: "6:33", notes: "Bib#:  622", city: "St. Charles", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('326'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 10, 7, 7, 30, 0)
  @run = Run.find_or_create_by(name: "Bank of America Chicago Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "46", seconds: "11", pace: "6:21", notes: "Bib#: 6084", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('242'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2018, 10, 21, 7, 0, 0)
  @run = Run.find_or_create_by(name: "Naperville Half Marathon and 5K", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "19", seconds: "57", pace: "6:07", notes: "Bib#: 1473", city: "Naperville", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  puts "----------2019----------"
  run_date = DateTime.new(2019, 4, 15, 10, 02, 0)
  @run = Run.find_or_create_by(name: "Boston Marathon", start_time: run_date.in_time_zone("Eastern Time (US & Canada)"), hours: "2", minutes: "57", seconds: "08", pace: "6:46", notes: "Bib#: 1183", city: "Boston", gear_id: Gear.find_shoe("Ravenna 10").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('655'), state_id: State.find_by_abbr("MA").id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 7, 21, 6, 30, 0)
  @run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "19", seconds: "44", pace: "6:05", notes: "Bib#: 1175", city: "Chicago", gear_id: Gear.find_shoe("Kinvara 10").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, personal_best: true, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 9, 22, 7, 0, 0)
  @run = Run.find_or_create_by(name: "Fox Valley Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "49", seconds: "34", pace: "6:28", notes: "Bib#: 347", city: "St. Charles", gear_id: Gear.find_shoe("Kinvara 10").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('326'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 10, 6, 8, 30, 0)
  @run = Run.find_or_create_by(name: "Bucktown 5K Run", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "18", seconds: "4", pace: "5:49", city: "Chicago", notes: "Bib#: 4291", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, personal_best: true, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 10, 13, 7, 30, 0)
  @run = Run.find_or_create_by(name: "Bank of America Chicago Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "43", seconds: "08", pace: "6:14", notes: "Bib#: 11184", city: "Chicago", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('100'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user.id, personal_best: true, completed_run: true)
  puts @run.inspect

  run_date = DateTime.new(2019, 11, 3, 9, 42, 0)
  @run = Run.find_or_create_by(name: "TCS New York City Marathon", start_time: run_date.in_time_zone("Eastern Time (US & Canada)"), hours: "3", minutes: "7", seconds: "16", pace: "7:09", notes: "Bib#: 2052", city: "New York City", gear_id: Gear.find_shoe_with_color("Cloudswift", "Rock/Slate").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('830'), state_id: State.find_by_abbr("NY").id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  puts "----------2020----------"
  run_date = DateTime.new(2020, 3, 8, 6, 55, 0)
  @run = Run.find_or_create_by(name: "Los Angeles Marathon", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), hours: "2", minutes: "48", seconds: "35", pace: "6:26", notes: "Bib#: 1356", city: "Los Angeles", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('850'), state_id: State.find_by_abbr("CA").id, run_type_id: run_type_id, user_id: user.id, completed_run: true)
  puts @run.inspect

  two_days_ago = 2.days.ago
  run_date = DateTime.new(two_days_ago.year, two_days_ago.month, two_days_ago.day, 10, 0, 0)
  @run = Run.find_or_create_by(name: "Testing", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), hours: "2", minutes: "28", seconds: "23", pace: "7:02", notes: nil, city: "Los Angeles", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('20'), mileage_total: BigDecimal('21'), elevation_gain: BigDecimal('1000'), state_id: State.find_by_abbr("CA").id, run_type_id: RunType.named("Long Run").id, user_id: user.id, completed_run: true)
  puts @run.inspect

  one_day_ago = 1.day.ago
  run_date = DateTime.new(one_day_ago.year, one_day_ago.month, one_day_ago.day, 18, 15, 0)
  @run = Run.find_or_create_by(name: "Testing 2", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), hours: 0, minutes: "30", seconds: "00", pace: "7:30", notes: nil, city: "Los Angeles", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('5'), mileage_total: BigDecimal('5'), elevation_gain: BigDecimal('252'), state_id: State.find_by_abbr("CA").id, run_type_id: RunType.named("Easy Run").id, user_id: user.id, completed_run: true)
  puts @run.inspect
  puts ""
end
puts ""