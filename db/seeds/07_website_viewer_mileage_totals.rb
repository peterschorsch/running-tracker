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

    number_of_runs = 21
    #Check if month is current calendar month and determing number of runs
    if (@monthly_total.month_start.beginning_of_day..@monthly_total.month_end.end_of_day).cover? DateTime.now
      day_number = DateTime.now.day
      number_of_runs = day_number <= 1 ? 1 : day_number-1
    end

    (1..number_of_runs).each do |number|
      run_date = DateTime.new(year, month, number)
      california_state_id = State.find_by_abbr("CA").id

      run_type_id = RunType.return_random_run_type_id

      gears = @website_viewer.gears.remove_default_shoe.active_shoes
      gear_id = gears.offset(rand(gears.count)).first.id

      pace = rand(6..9).to_s + ":" + rand(0..59).to_s.rjust(2, '0')

      if @website_viewer.runs.of_day(run_date).empty?
        @run = Run.create_random_run_record("Run", run_date.change(hour: rand(8..13), minute: rand(0..60), second: rand(0..60)), true, true, gear_id, "Los Angeles", california_state_id, run_type_id, @monthly_total.id, @website_viewer.id)
        #puts @run.inspect
      end
    end
  end
end

puts ""
puts "----------CREATE DEFAULT RUNS FOR CURRENT WEEK----------"
puts @website_viewer.create_weeklong_default_runs
puts ""