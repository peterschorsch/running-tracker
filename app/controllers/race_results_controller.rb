class RaceResultsController < ApplicationController
  def index
	@race_results = current_user.runs.of_run_type(RunType.named("Race").id).includes(:gear).order_by_oldest.group_by_year

    @personal_bests = current_user.runs.retrieve_personal_bests
  end
end
