class StatisticsController < ApplicationController
  def index
    @monthly_stats = current_user.monthly_totals.return_current_months_totals
    @yearly_stats = YearlyTotal.return_year_totals(Date.today.year)
    @all_time_stats = current_user.all_time_total

    @personal_bests = Run.retrieve_personal_bests
  end
end
