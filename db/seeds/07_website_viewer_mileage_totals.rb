@website_viewer = User.return_website_viewer

@all_time_total = AllTimeTotal.create_random_totals(@website_viewer.id)
puts @all_time_total.inspect

(2019..Date.current.year).each do |year|
  year_date = DateTime.new(year)
  @yearly_total = YearlyTotal.create_random_totals(@website_viewer.id, @all_time_total.id, year_date)
  puts @yearly_total.inspect

  if year == Date.current.year
    @last_month_of_year = Date.current
    @first_month_of_year = @last_month_of_year.beginning_of_year
  else
    @last_month_of_year = year_date.end_of_year.end_of_month.in_time_zone("Pacific Time (US & Canada)")
    @first_month_of_year = @last_month_of_year.beginning_of_year
  end
  puts ""

  puts "----------#{@website_viewer.concat_name} | #{year} MONTHLY TOTALS----------"
  (@first_month_of_year.month...@last_month_of_year.month+1).each do |month|
    month_end = DateTime.new(year, month, Time.days_in_month(month, year), 0, 0, 0, DateTime.now.zone).end_of_day
    month_start = month_end.beginning_of_month
      
    @monthly_total = MonthlyTotal.create_random_totals(@website_viewer.id, @yearly_total.id, month_start, month_end)
    puts @monthly_total.inspect

    (1..21).each do |number|
      run_date = DateTime.new(year, month, rand(1..1.week.ago.end_of_day.day))
      california_state_id = State.find_by_abbr("CA").id

      race_type = RunType.exclude_race_type
      run_type_id = race_type.offset(rand(race_type.count)).first.id

      gears = @website_viewer.gears.remove_default_shoe.active_shoes
      gear_id = gears.offset(rand(gears.count)).first.id

      pace = rand(6..9).to_s + ":" + rand(0..59).to_s.rjust(2, '0')
      if not Run.of_user(@website_viewer).where(:start_time => run_date..run_date.end_of_day).any?
        @run = Run.create(name: "LA Running", start_time: run_date.change(hour: rand(6..19), minute: rand(0..60), second: rand(0..60)), 
          planned_mileage: BigDecimal(rand(10)), mileage_total: BigDecimal(rand(10)), hours: rand(0..2), minutes: rand(1..60), seconds: rand(1..60), pace: pace, 
          elevation_gain: BigDecimal(rand(50..1000)), city: "Los Angeles", completed_run: true, active_run: true, 
          gear_id: gear_id, state_id: california_state_id, run_type_id: run_type_id, user_id: @website_viewer.id, monthly_total_id: @monthly_total.id)
        #puts @run.inspect
      end
    end
  end
end

puts ""
puts "----------CREATE DEFAULT RUNS FOR CURRENT WEEK----------"
puts @website_viewer.create_weeklong_default_runs
puts ""