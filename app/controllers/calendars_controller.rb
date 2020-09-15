class CalendarsController < ApplicationController
  def index
    #@obligations = Obligation.all.includes(:state) 
	@runs = Run.all.includes(:run_type)
  end
end
