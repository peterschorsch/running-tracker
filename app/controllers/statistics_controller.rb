class StatisticsController < ApplicationController
  def index
    @monthly_stats = current_user.yearly_totals.of_year.monthly_totals.of_month
    @all_time_stats = current_user.all_time_total
    @yearly_stats = @all_time_stats.yearly_totals.of_year
  end
end
