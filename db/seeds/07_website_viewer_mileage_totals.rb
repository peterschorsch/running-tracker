@website_viewer = User.return_website_viewer

@all_time_total = AllTimeTotal.create_random_totals(@website_viewer.id)
puts @all_time_total.inspect

(2019..Date.current.year).each do |year|
  year_date = Date.new(year)
  @yearly_total = YearlyTotal.create_random_totals(@website_viewer.id, @all_time_total.id, year_date)
  puts @yearly_total.inspect

  if year == Date.current.year
    @last_month_of_year = Date.current
    @first_month_of_year = @last_month_of_year.beginning_of_year
  else
    @last_month_of_year = year_date.end_of_year
    @first_month_of_year = @last_month_of_year.beginning_of_year
  end
  puts ""

  puts "----------#{@website_viewer.concat_name} | #{year} MONTHLY TOTALS----------"
  (@first_month_of_year.month...@last_month_of_year.month+1).each do |month|
    month_end = Date.new(year, month).end_of_month
    month_start = month_end.beginning_of_month
    # Pick a random number between 1 and the numbers of days in a month minus the number of weeks in a month
    number_of_runs = rand(1..(month_end.day-month_end.total_weeks))
    default_city = @website_viewer.default_city
      
    @monthly_total = MonthlyTotal.create_random_totals(@website_viewer.id, @yearly_total.id, month_start, month_end)
    puts @monthly_total.inspect

    # Check if month is current calendar month and determing number of runs
    # is the current date within the monthly total date
    seeder_date_matches_current_date = (@monthly_total.month_start.beginning_of_day..@monthly_total.month_end.end_of_day).cover? Date.current
    if seeder_date_matches_current_date
      day_number = Date.current.day
      number_of_runs = day_number <= 1 ? 1 : day_number-1
    end

    # So future runs won't be created
    run_day_end = seeder_date_matches_current_date ? (Date.current-1.day).day : month_end.day
    run_day_array = (1..run_day_end).to_a

    (1..number_of_runs).each do |number|
      random_day_selection = run_day_array.sample
      run_date = DateTime.new(year, month, random_day_selection)

      if @website_viewer.runs.of_day(run_date).empty?
        shoe_id = @website_viewer.shoes.return_random_shoe.id
        run_type_id = RunType.return_random_run_type_id

        state_id = State.find_by_name(@website_viewer.default_state).id

        @run = Run.create_random_run_record(@website_viewer.concat_user_default_city_run_name, Run.return_random_run_start_time(run_date), true, shoe_id, default_city, state_id, run_type_id, @monthly_total.id, @website_viewer.id)
        #puts @run.inspect
        run_day_array-[random_day_selection]
      end
    end
  end
end

puts ""
puts "----------CREATE DEFAULT RUNS FOR CURRENT WEEK----------"
puts @website_viewer.create_weeklong_default_runs
puts ""