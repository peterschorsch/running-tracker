class StatisticsController < ApplicationController
  def index
    #@monthly_stats =
    #@yearly_stats =
    #@all_time_stats = 

    @personal_bests = Run.retrieve_personal_bests
  end
end
