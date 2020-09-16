class CalendarsController < ApplicationController
  def index
    #@obligations = Obligation.all.includes(:state) 
	@runs = Run.all.includes(:run_type, :gear)
	@run_types = RunType.active_run_types.order_by_name
  end
end
