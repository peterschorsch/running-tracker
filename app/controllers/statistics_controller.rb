class StatisticsController < ApplicationController
  def index
    @monthly_stats = Run.return_monthly_stats(current_user, Date.current)#current_user.monthly_totals.return_current_months_totals
    @all_time_stats = current_user.all_time_total
    @yearly_stats = @all_time_stats.yearly_totals.of_year(Date.current.year)
  end
end
